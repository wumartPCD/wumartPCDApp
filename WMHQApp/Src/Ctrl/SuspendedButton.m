
#import <UIKit/UIKit.h>
#import "SuspendedButton.h"

@implementation SuspendedButton
@synthesize buttonListView = _buttonListView;
@synthesize baseView = _baseView;

static SuspendedButton *_instance = nil;

#pragma mark - 继承方法
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _isShowingButtonList = NO;
        //_isBackUp = NO;
        //self.hidden = YES;
        //_isTest = NO;
        //[self httpRequest];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:BUTTON_AVAILABLE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showButton) name:BUTTON_AVAILABLE object:nil];
    }
    return self;
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"touchBegan");
    
    _originalPosition = [[touches anyObject] locationInView:self];
    _tempCenter = self.center;
    
    self.backgroundColor = [UIColor blueColor];
    
    CGAffineTransform toBig = CGAffineTransformMakeScale(1.2, 1.2);
    
    [UIView animateWithDuration:0.1 animations:^{
        // Translate bigger
        self.transform = toBig;
        
    } completion:^(BOOL finished)   {}];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"touchMove");
    
    CGPoint currentPosition = [[touches anyObject] locationInView:self];
    float detaX = currentPosition.x - _originalPosition.x;
    float detaY = currentPosition.y - _originalPosition.y;
    
    CGPoint targetPositionSelf = self.center;
    CGPoint targetPositionButtonList = _buttonListView.center;
    targetPositionSelf.x += detaX;
    targetPositionSelf.y += detaY;
    targetPositionButtonList.x += detaX;
    targetPositionButtonList.y += detaY;
    
    self.center = targetPositionSelf;
    _buttonListView.center = targetPositionButtonList;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"touchCancell");
    
    // 触发touchBegan后，tap手势被识别后会将touchMove和touchEnd的事件截取掉触发自身手势回调，然后运行touchCancell。touchBegan中设置的按钮状态在touchEnd和按钮触发方法两者中分别设置还原。
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"touchEnd");
    
    CGAffineTransform toNormal = CGAffineTransformTranslate(CGAffineTransformIdentity, 1/1.2, 1/1.2);
    CGPoint newPosition = [self correctPosition:self.frame.origin];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        // Translate normal
        self.transform = toNormal;
        self.backgroundColor = [UIColor greenColor];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.frame = CGRectMake(newPosition.x, newPosition.y, self.bounds.size.width, self.bounds.size.height);
            [self adjustButtonListView];
        }];
        
    }];
}

#pragma mark - 类方法
+ (SuspendedButton *)suspendedButtonWithCGPoint:(CGPoint)pos inView:(UIView *)baseview
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SuspendedButton alloc] initWithCGPoint:pos];
        _instance.baseView = baseview;
        [_instance constructUI];
        [baseview addSubview:_instance];
    });
    
    return _instance;
}

+ (void)deleteSuspendedButton
{
    [_instance removeFromSuperview];
}

#pragma mark - 辅助方法
- (id)initWithCGPoint:(CGPoint)pos
{
    _windowSize = [UIScreen mainScreen].bounds; //封装了获取屏幕Size的方法
    
    CGPoint newPosition = [self correctPosition:pos];
    
    return [self initWithFrame:CGRectMake(newPosition.x, newPosition.y, 50, 50)];
}

- (CGPoint)correctPosition:(CGPoint)pos
{
    CGPoint newPosition;
    
    if ((pos.x + 50 > _windowSize.size.width) || (pos.x > _windowSize.size.width/2-25)) {
        newPosition.x = _windowSize.size.width - 50;
        _isOnLeft = NO;
    } else {
        newPosition.x = 0;
        _isOnLeft = YES;
    }
    
    (pos.y + 50 > _windowSize.size.height)?(newPosition.y = _windowSize.size.height - 50):((pos.y < 0)?newPosition.y = 0:(newPosition.y = pos.y));
    
    return newPosition;
}

- (void)constructUI
{
    self.backgroundColor = [UIColor greenColor];
    self.alpha = 0.6;
    self.layer.cornerRadius = 10;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tiggerButtonList)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    NSUInteger numOfButton = 4;
    self.buttonListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, numOfButton*40, 40)];
    _buttonListView.backgroundColor = [UIColor blueColor];
    _buttonListView.alpha = 0;
    _buttonListView.layer.cornerRadius = 10;
    
    [self createButtonByNumber:numOfButton withSize:CGSizeMake(40, 40) inView:(UIView *)_buttonListView];
    _buttonListView.hidden = YES;
    [_baseView addSubview:_buttonListView];
}

- (void)createButtonByNumber:(NSUInteger)number withSize:(CGSize)size inView:(UIView *)view
{
    //子按钮的UI效果自定义
    for (NSUInteger i = 0; i < number; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(optionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 2000;
        button.frame = CGRectMake(0 + i*size.width, 0, size.width, size.height);
        button.tintColor = [UIColor redColor];
        [view addSubview:button];
    }
}

- (void)adjustButtonListView
{
    if (_isOnLeft) {
        _buttonListView.frame = CGRectMake(50, self.center.y - 20, _buttonListView.bounds.size.width, _buttonListView.bounds.size.height);
    } else {
        _buttonListView.frame = CGRectMake((_windowSize.size.width - 50 - _buttonListView.bounds.size.width), self.center.y - 20, _buttonListView.bounds.size.width, _buttonListView.bounds.size.height);
    }
}

#pragma mark - 按钮回调
- (void)tiggerButtonList
{
    //NSLog(@"tiggerTap");
    
    _isShowingButtonList = !_isShowingButtonList;
    
    CGAffineTransform toNormal = CGAffineTransformTranslate(CGAffineTransformIdentity, 1/1.2, 1/1.2);
    [UIView animateWithDuration:0.1 animations:^{
        // Translate normal
        self.transform = toNormal;
        self.backgroundColor = [UIColor greenColor];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.center = _tempCenter;
            [self adjustButtonListView];
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                _buttonListView.hidden = !_isShowingButtonList;
                _isShowingButtonList ? (_buttonListView.alpha = 0.6) : (_buttonListView.alpha = 0);
            }];
        }];
    }];
}

- (void)optionsButtonPressed:(UIButton *)button
{
    //NSLog(@"buttonNumberPressed:%d",button.tag);
    
    switch (button.tag) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
}
@end
