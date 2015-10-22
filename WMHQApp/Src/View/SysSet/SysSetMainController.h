
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BasePortraitController.h"

@interface SysSetMainController : BasePortraitController


@property (retain, nonatomic) IBOutlet UIScrollView *configScroll;
@property (retain, nonatomic) IBOutlet UIView *titleView;
@property (retain, nonatomic) IBOutletCollection(UILabel) NSArray *badgedLabels;
@property (retain, nonatomic) IBOutlet UIButton *configButton;

- (IBAction)checkVersion:(id)sender;
- (IBAction)changePswd:(id)sender;
- (IBAction)quitCurrentAccount:(id)sender;

@end
