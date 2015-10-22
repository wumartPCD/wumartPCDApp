
#import "MerchListViewCell.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "CommConst.h"
#import "GlobalApp.h"

@implementation MerchListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

-(void) loadData:(NSString *)merchInfo index:(int)index sWidth:(int)sWidth;
{
    int rowNum = index;
    
    tableRowView =[[UIView alloc]initWithFrame:CGRectMake(1, 0, sWidth-2, 0)];
    tableRowView.backgroundColor = RGB_COLOR(@"#B8B8B8");
    [self addSubview:tableRowView];
    
    if (rowNum==0) {
        [self createRowView:@"商品编码-商品名称" index:rowNum width:sWidth onView:tableRowView];
        rowNum++;
    }
    
    [self createRowView:merchInfo index:rowNum width:sWidth onView:tableRowView];
}

-(void) createRowView:(NSString *)merchInfo index:(int)index width:(int)sWidth onView:(UIView *)view;
{
    int rowHeight = 25;
    UIView *lastView = view.subviews.lastObject;
    CGFloat top =0;
    if(lastView)
    {
        top = lastView.bottom;
    }
    
    NSArray *arr = [merchInfo componentsSeparatedByString:@"-"];
    
    UILabel * codeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, top+1, 80, rowHeight-1)];
    [codeLbl setText:[@"  " stringByAppendingString:arr[0]]];
    [codeLbl setFont:[UIFont systemFontOfSize:13.0]];
    if (index == 0) {
        [codeLbl setBackgroundColor:RGB_COLOR(@"#9fe7ba")];
    }else if(lastView){
        [codeLbl setBackgroundColor:RGB_COLOR(@"#ecfaff")];
    }else{
        if (index%2 == 0) {
            [codeLbl setBackgroundColor:RGB_COLOR(@"#ecfaff")];
        }else{
            [codeLbl setBackgroundColor:[UIColor whiteColor]];
        }
    }
    [view addSubview:codeLbl];
    
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(81, top+1, sWidth-2-81, rowHeight-1)];
    [nameLbl setText:[@"  " stringByAppendingString:arr[1]]];
    [nameLbl setFont:[UIFont systemFontOfSize:13.0]];
    if (index == 0) {
        [nameLbl setBackgroundColor:RGB_COLOR(@"#9fe7ba")];
    }else if(lastView){
        [nameLbl setBackgroundColor:RGB_COLOR(@"#ecfaff")];
    }else{
        if (index%2 == 0) {
            [nameLbl setBackgroundColor:RGB_COLOR(@"#ecfaff")];
        }else{
            [nameLbl setBackgroundColor:[UIColor whiteColor]];
        }
    }
    [view addSubview:nameLbl];
    
    CGFloat bottom = codeLbl.bottom;
    [view setSize:CGSizeMake(sWidth-2, view.bottom)];
}

@end
