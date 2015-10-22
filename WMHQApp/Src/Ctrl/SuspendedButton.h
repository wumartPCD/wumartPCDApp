
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define BUTTON_AVAILABLE @"BUTTONAVAILABLE"

@interface SuspendedButton : UIView
{
    BOOL _isShowingButtonList;
    BOOL _isOnLeft;
    BOOL _isBackUp;
    BOOL _isTest;
    CGPoint _tempCenter;
    CGPoint _originalPosition;
    CGRect _windowSize;
    UIView *_buttonListView;
    UIView *_baseView;
}

@property (nonatomic,retain) UIView *buttonListView;
@property (nonatomic,retain) UIView *baseView;
@end
