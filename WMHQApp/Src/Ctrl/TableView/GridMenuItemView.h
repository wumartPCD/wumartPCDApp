
#import <UIKit/UIKit.h>

@protocol MenuItemDelegate;
@interface GridMenuItemView : UIView {
    int itemWidth;
    NSString *image;
    NSString *titleText;
    NSString *funcMenuID;
    UIViewController *vcToLoad;
}

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) int itemWidth;
//@property (nonatomic, assign) NSString *menuID;
@property (nonatomic, assign) id <MenuItemDelegate> delegate;

+ (id) initWithTitle:(NSString *)menuID title:(NSString *)title imgName:(NSString *)imgName uiCtrl:(UIViewController *)uiCtrl;

@end

@protocol MenuItemDelegate <NSObject>
@optional

- (void)launch:(NSString *)menuID :(UIViewController *)vcToLoad;

@end