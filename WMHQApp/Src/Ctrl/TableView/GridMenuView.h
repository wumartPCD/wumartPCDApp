
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GridMenuItemView.h"

@interface GridMenuView : UIView <MenuItemDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    UIScrollView *itemsContainer;
}

@property (nonatomic, assign) BOOL isSubMenu;
@property (nonatomic, assign) int colNum;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIImage *launcher;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *itemCounts;
@property (nonatomic, retain) UINavigationController *homeNaviCtrler;
@property (nonatomic, retain) BaseViewController *homeCtrler;


+ (id) initWithTitle:(CGRect)bounds items:(NSMutableArray *)menuItems fontSize:(CGFloat)fontSize colNum:(int)colNum homeCtrler:(BaseViewController *)homeCtrler;

- (void) refresh:(CGRect)bounds :(NSMutableArray *)menuItems;

@end
