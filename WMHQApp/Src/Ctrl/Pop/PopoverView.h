
#import <UIKit/UIKit.h>

@interface PopoverView : UIView

- (id)initWithFrame:(CGSize)size superView:(UIView *)superView subView:(UIView *)subView;

- (void)show;
- (void)hidden;
    
@end
