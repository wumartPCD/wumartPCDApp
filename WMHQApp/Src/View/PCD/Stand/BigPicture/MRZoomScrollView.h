
#import <UIKit/UIKit.h>

@protocol MRZoomScrollViewDelegate <NSObject>

-(void)tapGesture;

@end

@interface MRZoomScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
}

- (void) loadImageView:(NSString *)url;

- (UIImageView *) getImageView;

@property (nonatomic, assign)id<MRZoomScrollViewDelegate> zoomScrolleViewDelegate;
@end
