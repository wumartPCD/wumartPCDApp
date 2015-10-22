
#import <UIKit/UIKit.h>

@interface MerchListViewCell : UITableViewCell
{
    UIView *tableRowView;         //行view
}

-(void) loadData:(NSString *)merchInfo index:(int)index sWidth:(int)sWidth;
@end
