
#import <UIKit/UIKit.h>

@class ComboBoxList;
@protocol ComboBoxListDelegate
- (void) onComboBoxListSelect:(id)sender index:(int)index;
@end

@interface ComboBoxList : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    UIImageView *imgView;
}
@property (nonatomic, retain) id <ComboBoxListDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideDropDown:(CGRect )frame;
- (id)showDropDown:(UIButton *)sender:(CGFloat *)height:(NSArray *)arr:(NSArray *)imgArr:(NSString *)direction;
@end
