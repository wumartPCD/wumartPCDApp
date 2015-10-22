
#import <UIKit/UIKit.h>
#import "BaseLandscapeController.h"

@class BaseSlideViewController;
@protocol SlideViewControllerDelegate;

#pragma mark - SWRevealViewController Class

// Enum values for setFrontViewPosition:animated:
typedef enum
{
    FrontViewPositionLeftSideMostRemoved,
    FrontViewPositionLeftSideMost,
    FrontViewPositionLeftSide,

    // Left position, rear view is hidden behind front controller
	FrontViewPositionLeft,
    
    // Right possition, front view is presented right-offseted by rearViewRevealWidth
	FrontViewPositionRight,
    
    // Right most possition, front view is presented right-offseted by rearViewRevealWidth+rearViewRevealOverdraw
	FrontViewPositionRightMost,
    
    FrontViewPositionRightMostRemoved,
    
} FrontViewPosition;

@interface BaseSlideViewController : BaseLandscapeController

// Object instance init and rear view setting
- (id)initWithRearViewController:(UIViewController *)rearViewController frontViewController:(UIViewController *)frontViewController;

// Rear view controller, can be nil if not used
@property (readonly, nonatomic) UIViewController *rearViewController;

// Optional right view controller, can be nil if not used
@property (strong, nonatomic) UIViewController *rightViewController;

// Front view controller, can be nil on initialization but must be supplied by the time its view is loaded
@property (strong, nonatomic) UIViewController *frontViewController;
- (void)setFrontViewController:(UIViewController *)frontViewController animated:(BOOL)animated;

// Front view position, use this to set a particular position state on the controller
// On initialization it is set to FrontViewPositionLeft
@property (assign, nonatomic) FrontViewPosition frontViewPosition;
- (void)setFrontViewPosition:(FrontViewPosition)frontViewPosition animated:(BOOL)animated;

// Toogles the current state of the front controller between Left or Right and fully visible
// Use setFrontViewPosition to set a particular position
- (void)revealToggleAnimated:(BOOL)animated;
- (void)rightRevealToggleAnimated:(BOOL)animated;

// The following methods are meant to be directly connected to the action method of a button
// to perform user triggered postion change of the controller views. This is ussually added to a
// button on top left or right of the frontViewController
- (void)revealToggle:(id)sender;
- (void)rightRevealToggle:(id)sender;

// The following method will provide a panGestureRecognizer suitable to be added to any view on the frontController
// in order to perform usual drag and swipe gestures on the frontViewController to reveal the rear views. This
// is usually added on the top bar of a front controller.
- (UIPanGestureRecognizer*)panGestureRecognizer;

// The following properties are provided for further customization, they are set to default values on initialization,
// you should not generally have to set them

// Defines how much of the rear view is shown, default is 260.
@property (assign, nonatomic) CGFloat rearViewRevealWidth;
@property (assign, nonatomic) CGFloat rightViewRevealWidth;

// Defines how much of an overdraw can occur when dragging further than 'rearViewRevealWidth', default is 60.
@property (assign, nonatomic) CGFloat rearViewRevealOverdraw;
@property (assign, nonatomic) CGFloat rightViewRevealOverdraw;

// If YES (the default) the controller will bounce to the Left position when dragging further than 'rearViewRevealWidth'
@property (assign, nonatomic) BOOL bounceBackOnOverdraw;
@property (assign, nonatomic) BOOL bounceBackOnLeftOverdraw;

// If YES (default is NO) the controller will allow permanent dragging up to the rightMostPosition
@property (assign, nonatomic) BOOL stableDragOnOverdraw;
@property (assign, nonatomic) BOOL stableDragOnLeftOverdraw;

// Velocity required for the controller to toggle its state based on a swipe movement, default is 300
@property (assign, nonatomic) CGFloat quickFlickVelocity;

// Default duration for the revealToggle animation, default is 0.25
@property (assign, nonatomic) NSTimeInterval toggleAnimationDuration;

// Defines the radius of the front view's shadow, default is 2.5f
@property (assign, nonatomic) CGFloat frontViewShadowRadius;

// Defines the radius of the front view's shadow offset default is {0.0f,2.5f}
@property (assign, nonatomic) CGSize frontViewShadowOffset;

// The class properly handles all the relevant calls to appearance methods on the contained controllers.
// Moreover you can assign a delegate to let the class inform you on positions and animation activity.

// Delegate
@property (weak, nonatomic) id<SlideViewControllerDelegate> delegate;

@end

#pragma mark - SWRevealViewControllerDelegate Protocol

@protocol SlideViewControllerDelegate<NSObject>

@optional

- (void)revealController:(BaseSlideViewController *)revealController willMoveToPosition:(FrontViewPosition)position;
- (void)revealController:(BaseSlideViewController *)revealController didMoveToPosition:(FrontViewPosition)position;

- (void)revealController:(BaseSlideViewController *)revealController animateToPosition:(FrontViewPosition)position;

- (void)revealControllerPanGestureBegan:(BaseSlideViewController *)revealController;
- (void)revealControllerPanGestureEnded:(BaseSlideViewController *)revealController;

@end


#pragma mark - UIViewController(SWRevealViewController) Category

// We add a category of UIViewController to let childViewControllers easily access their parent SWRevealViewController
@interface UIViewController(SlideViewController)

- (BaseSlideViewController*)revealViewController;

@end

// This will allow the class to be defined on a storyboard
#pragma mark - SWRevealViewControllerSegue

@interface SlideViewControllerSegue : UIStoryboardSegue

@property (strong) void(^performBlock)( SlideViewControllerSegue* segue, UIViewController* svc, UIViewController* dvc );

@end


