
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"

@interface ChangePswdController : BasePortraitController

@property (nonatomic, strong) UITextField *oldPswdField;
@property (nonatomic, strong) UITextField *setPswdField;
@property (nonatomic, strong) UITextField *cfrmPswdField;

@property (nonatomic, strong) UIButton *submitBtn;

@end
