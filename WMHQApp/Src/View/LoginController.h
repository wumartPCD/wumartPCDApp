
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "SysMangDao.h"
#import "LoginUserRtnVO.h"

@interface LoginController : BasePortraitController

- (LoginUserRtnVO *)execLogin:(NSString *) userCode pswd:(NSString *)pswd;

@property (nonatomic, strong) UITextField * usernameField;

@property (nonatomic, strong) UITextField * passwordField;

@property (nonatomic, strong) UIButton *fetchPswdBtn;

@property (nonatomic, strong) UIButton *loginBtn;

@end
