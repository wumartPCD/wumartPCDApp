
#import "StandListViewCell.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "CommConst.h"

@implementation StandListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        globalApp=[GlobalApp sharedInstance];
        
        naviWhere = [globalApp getValue:CUR_PCD_NAVI_WHERE_BLANK];
        
        tableLblView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, 75, 0)];
        
        NSArray *array = @[@" 促销位编号",@" 门店模板",@" 档       期",@" 营运课组",@" U课或主题",@" 促销资源"];
        for(int i = 0; i < array.count; i ++)
        {
            [self createTableCell:array[i] view:tableLblView isLabel:TRUE];
        }
        [self addSubview:tableLblView];
        
        CGFloat imgPosX = 5 + 155 + 5;
        CGFloat imgWidth = self.width - imgPosX - 5;
        
        standImgView = [[UIImageView alloc]initWithFrame:CGRectMake(imgPosX, 2, imgWidth, 122)];
        standImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:standImgView];
    }
    
    return self;
}

-(void)createDataView:(PcdStandRtnVO *)stand
{
    tableDataRow =[[UIView alloc]initWithFrame:CGRectMake(tableLblView.right + 2, tableLblView.top, 80, tableLblView.height)];
    [self addSubview:tableDataRow];
    
    [self createTableCell:stand.StandCode view:tableDataRow isLabel:FALSE];
    [self createTableCell:[naviWhere getSiteTmplName:stand.SiteTmpl] view:tableDataRow isLabel:FALSE];
    [self createTableCell:stand.Aktnr view:tableDataRow isLabel:FALSE];
    [self createTableCell:stand.Oper view:tableDataRow isLabel:FALSE];
    [self createTableCell:[stand.Puunit stringByAppendingString:[naviWhere getThemeName:stand.Theme]] view:tableDataRow isLabel:FALSE];
    [self createTableCell:[naviWhere getPcdTypeName:stand.PcdType] view:tableDataRow isLabel:FALSE];
}

-(void)createTableCell:(NSString *)name view:(UIView*)view isLabel:(BOOL) flag
{
    UIView *lastView = view.subviews.lastObject;
    CGFloat top =0;
    CGFloat height;
    if(lastView)
    {
        top = lastView.bottom + 1;
    }
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, top, view.width, 20)];
    [label setText:[@" " stringByAppendingString:name ]];
    [label setFont:[UIFont systemFontOfSize:12.0]];
    if (flag) {
        [label setBackgroundColor:RGB_COLOR(@"#9fe7ba")];
    }else {
        [label setBackgroundColor:RGB_COLOR(@"#ecfaff")];
    }
    
    [view addSubview:label];
    height = label.bottom;
    
    [view setSize:CGSizeMake(view.width, height)];
}

-(void) loadData:(PcdStandRtnVO *)stand
{
    [self createDataView:stand];
    
    [standImgView sd_setImageWithURL: [NSURL URLWithString: stand.ImgUrl]];
}
@end
