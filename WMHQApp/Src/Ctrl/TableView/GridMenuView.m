
#import "GridMenuView.h"
#import "GlobalApp.h"
#import "CommConst.h"
#import "BaseReportsController.h"
#import "BaseRptMenuController.h"
#import "EmbedOAController.h"
#import "EmbedMailController.h"

@implementation GridMenuView

@synthesize isSubMenu, colNum, fontSize, items, title, launcher, itemCounts, homeNaviCtrler, homeCtrler;

- (id) initWithTitle:(CGRect)bounds :(NSMutableArray *)menuItems :(CGFloat)fontSize :(int)colNum :(BaseViewController *)homeCtrler{
    self = [super initWithFrame:bounds];
    [self setUserInteractionEnabled:YES];
    if (self) {
        self.isSubMenu=FALSE;
        self.colNum=colNum;
        self.fontSize=fontSize;
        self.homeNaviCtrler = homeCtrler.navigationController;
        self.homeCtrler=homeCtrler;

        itemsContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(4, 5, bounds.size.width-8, bounds.size.height-50)];
        itemsContainer.delegate = self;
        [itemsContainer setScrollEnabled:YES];
        itemsContainer.showsHorizontalScrollIndicator = NO;
        itemsContainer.showsVerticalScrollIndicator = NO;
        [self addSubview:itemsContainer];
        
        [self reLoadData:bounds :menuItems :FALSE];
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate=self;
        [self addGestureRecognizer:singleTap];
        singleTap.cancelsTouchesInView = NO;
    }
    
    return self;
}

+ (id) initWithTitle:(CGRect)bounds items:(NSMutableArray *)menuItems fontSize:(CGFloat)fontSize colNum:(int)colNum homeCtrler:(UINavigationController *)homeCtrler {
    GridMenuView *tmpInstance = [[GridMenuView alloc] initWithTitle:bounds :menuItems :fontSize :colNum :homeCtrler];
    
    return tmpInstance;
};

- (void) reLoadData:(CGRect)bounds :(NSMutableArray *)menuItems :(BOOL)isRefresh{
    for(UIView *view in [itemsContainer subviews])
    {
        [view removeFromSuperview];
    }
    
    self.items = menuItems;
    int counter = 0;
    int horgap = 0;
    int vergap = 0;
    int itemWidth = (ceil((float)(bounds.size.width) / colNum));
    int rowNum = 1;
    for (GridMenuItemView *item in self.items) {
        item.itemWidth=itemWidth;
        item.delegate = self;
        item.fontSize=self.fontSize;
        //[item setFrame:CGRectMake(item.frame.origin.x + horgap, item.frame.origin.y + vergap, itemWidth, itemWidth)];
        [item setFrame:CGRectMake(horgap, vergap, itemWidth, itemWidth)];
        [itemsContainer addSubview:item];
        horgap = horgap + itemWidth;
        counter = counter + 1;
        if(counter % colNum == 0){
            vergap = vergap + itemWidth;
            horgap = 0;
            rowNum++;
        }
    }

    [itemsContainer setContentSize:CGSizeMake( bounds.size.width-8, rowNum * itemWidth + 200)];
    
    if (isRefresh) {
        [itemsContainer setFrame:CGRectMake(4, 5, bounds.size.width-8, self.bounds.size.height-10)];
    }
}

- (void) refresh:(CGRect)bounds :(NSMutableArray *)menuItems {
    [self reLoadData:bounds :menuItems :TRUE];
}

- (CGAffineTransform)offscreenQuadrantTransformForView:(UIView *)theView {
    CGPoint parentMidpoint = CGPointMake(CGRectGetMidX(theView.superview.bounds), CGRectGetMidY(theView.superview.bounds));
    CGFloat xSign = (theView.center.x < parentMidpoint.x) ? -1.f : 1.f;
    CGFloat ySign = (theView.center.y < parentMidpoint.y) ? -1.f : 1.f;
    return CGAffineTransformMakeTranslation(xSign * parentMidpoint.x, ySign * parentMidpoint.y);
}

- (void)launch:(NSString *)menuID :viewController {
    
    if(menuID != nil){
        if (!self.isSubMenu) {
            GlobalApp *globalApp=[GlobalApp sharedInstance];
            [globalApp putValue:CUR_SUPER_MENU_ID value:menuID];
        }
    }
    if ([viewController isKindOfClass:[EmbedOAController class]]) {
        NSURL *url=[NSURL URLWithString:@"http://moa.wumart.com"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if ([viewController isKindOfClass:[EmbedMailController class]]) {
        NSURL *url=[NSURL URLWithString:@"http://mail.wumart.com"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if ([viewController isKindOfClass:[BaseReportsController class]]) {
        BaseReportsController *ctrl = (BaseReportsController *)viewController;
        [ctrl loadReportsByFuncNo:menuID];
    }else{
        [homeNaviCtrler pushViewController:viewController animated:true];
    }
    
    if (self.isSubMenu) {
        NSString *evnName=[[GlobalApp sharedInstance] getValue:CUR_SHOW_SLIDE_MENU_VIEW_EVN_NM];
        [[NSNotificationCenter defaultCenter] postNotificationName:evnName object:nil];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

//轻点手势关联的方法
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    if ([homeCtrler isKindOfClass:[BaseRptMenuController class]]) {
        BaseRptMenuController *ctrl = (BaseRptMenuController *)homeCtrler;
        [ctrl closeDropdown];
    }
}

@end

