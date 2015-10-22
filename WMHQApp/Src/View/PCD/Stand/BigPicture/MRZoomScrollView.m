//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"

#define MRScreenWidth      [[UIScreen mainScreen]bounds].size.width
#define MRScreenHeight     [[UIScreen mainScreen]bounds].size.height

@interface MRZoomScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void) loadImageView:(NSString *)url
{
    imageView = [[UIImageView alloc]init];
//    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UIImage *img = imageView.image;
    
    CGFloat width =  MRScreenWidth;
    CGFloat height = MRScreenWidth*(img.size.height/img.size.width);
//    CGFloat posY = (MRScreenHeight - height) / 2;
//    imageView.frame = CGRectMake(0, posY-10, width , height);
    imageView.frame = CGRectMake(0, 0, width, height);
    [imageView setCenter:self.center];
    
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [imageView addGestureRecognizer:tapGesture];
    self.maximumZoomScale = 4.0;
}

- (UIImageView *) getImageView
{
    return imageView;
}

#pragma mark - Zoom methods

-(void)tapGesture:(UITapGestureRecognizer *)gesture
{
    [self.zoomScrolleViewDelegate tapGesture];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  =  self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    scrollView.scrollEnabled = YES;
    [scrollView setZoomScale:scale animated:NO];
}

//实现图片在缩放过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    imageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
    
}

@end
