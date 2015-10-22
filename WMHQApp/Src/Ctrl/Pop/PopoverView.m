
#import "PopoverView.h"

@interface PopoverView()

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, assign) CGSize viewSize;

@end
@implementation PopoverView

- (id)initWithFrame:(CGSize)size superView:(UIView *)superView subView:(UIView *)subView
{
    self = [super initWithFrame:superView.frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        self.viewSize = size;
        self.superView = superView;
        self.subView = subView;
        
        [self addSubview:self.subView];
    }
    return self;
}

- (void)show
{
    self.subView.hidden = NO;
    
    [self setFrame:CGRectMake(0, 0, 0, 0)];
    //self.layer.anchorPoint = CGPointMake(self.superView.frame.origin.x, self.superView.frame.origin.y);
    
    [self setNeedsDisplay];
    
    [self.superView addSubview:self];
    [self bringSubviewToFront:self.subView];
}

- (void)hidden
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.1f;
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        self.subView.hidden = YES;
        //[self.subView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
