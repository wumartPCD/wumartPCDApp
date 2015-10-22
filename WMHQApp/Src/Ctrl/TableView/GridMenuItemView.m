
#include <stdlib.h>
#import "GridMenuItemView.h"
#import "GridMenuView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "UIView+Frame.h"

@implementation GridMenuItemView

@synthesize fontSize,itemWidth, delegate;

#pragma mark - UI actions

- (void) clickItem:(id) sender {
    [[self delegate] launch: funcMenuID :vcToLoad];
}

#pragma mark - Initialization

- (id) initWithTitle:(NSString *)menuID :(NSString *)title :(NSString *)imgName :(UIViewController *)uiCtrl {
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        vcToLoad = uiCtrl;
        image = imgName;
        titleText = title;
        funcMenuID=menuID;
    }
    return self;
}

+ (id) initWithTitle:(NSString *)menuID title:(NSString *)title imgName:(NSString *)imgName uiCtrl:(UIViewController *)uiCtrl  {
    GridMenuItemView *tmpInstance = [[GridMenuItemView alloc] initWithTitle:menuID :title :imgName :uiCtrl];
    return tmpInstance;
}

- (void) drawRect:(CGRect)rect {
    int width = itemWidth - 30;
    if (titleText == Nil) {
        width = itemWidth;
    }
    
    UIImage *img;
    if (titleText == Nil && [image rangeOfString:@"http://"].location != NSNotFound) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView sd_setImageWithURL:[NSURL URLWithString:image]];
        img = imgView.image;
        CGFloat width = img.size.width;
        CGFloat height = img.size.height;
        [img drawInRect:CGRectMake(0, 0, itemWidth, itemWidth*(height/width))];
    }else{
        img = [UIImage imageNamed:image];
        [img drawInRect:CGRectMake(10, 5, width, width)];
        UIFont *bold14 = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
        NSString* text = titleText;
        [text drawInRect:CGRectMake(0, width+5, itemWidth-10, 16.0) withFont:bold14 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentCenter];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, itemWidth, itemWidth)];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    //button.tag = tag;
    
    //UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLong:)];
    //[button addGestureRecognizer:longPress];
    
    [self addSubview:button];
}

@end
