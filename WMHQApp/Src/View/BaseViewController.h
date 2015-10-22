
#import <UIKit/UIKit.h>
#import "CommConst.h"
#import "GlobalApp.h"
#import "UIView+Frame.h"

#define kXHOFFSET_FOR_KEYBOARD 80.0
#define kSCREEN_WIDTH  self.view.bounds.size.width
#define kSCREEN_HEIGHT self.view.bounds.size.height

@interface BaseViewController : UIViewController

{
    UINavigationBar *curNaviBar;
}
- (void)onBackBtnClick: (id) sender;
- (UINavigationItem *)showNavigationBar:(NSString *) title isLandscape:(BOOL) isLandscape showBackBtn:(BOOL) showBackBtn;

- (void)displayHintInfo:(NSString *) mesg;
- (BOOL)isContainString:(NSString *) str subStr:(NSString *) subStr;

-(void)autoResizeView;
- (BOOL)isPortrait;
- (BOOL)isPAD;
- (int)getScreenWidth;
- (int)getScreenHeight;

@end
