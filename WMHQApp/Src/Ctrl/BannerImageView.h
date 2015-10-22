
#import <UIKit/UIKit.h>

@interface BannerImageView : UIView<UIScrollViewDelegate>
{
    BOOL isFromStart;
    
    UIScrollView  *scrollView;      //声明一个UIScrollView
    UIPageControl *pageControl;     //声明一个UIPageControl
    NSMutableArray *viewController; //存放UIViewController的可变数组
    NSTimer *timer;
}

@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, assign) NSArray *imageArr;

+ (id) initWithImages:(CGRect)bounds items:(NSArray *)imageArr;

@end
