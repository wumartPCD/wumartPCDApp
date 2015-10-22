//
//  ShowBigViewController.m
//  testKeywordDemo
//
//  Created by mei on 14-8-18.
//  Copyright (c) 2014年 Bluewave. All rights reserved.
//



#import "PCDStandImgViewController.h"
#import "UIView+Frame.h"

#import "CommConst.h"
#define IOS7LATER  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

@implementation ShowImage

-(id)init
{
    if (self = [super init])
    {
        self.stateOfSelect = YES;
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setBackgroundImage:[UIImage imageNamed:@"isSeleted"] forState:UIControlStateNormal];
        [self.button setFrame:CGRectMake(0, 0, 30, 30)];
    }
    return  self;
}

@end

#pragma mark - ShowBigViewController

@interface PCDStandImgViewController ()

@property(strong, nonatomic) NSMutableArray *imageArray;
@property(assign, nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) NSMutableArray *showImageArrary;
@property (assign, nonatomic) int sendNumber;
@property (nonatomic, strong) MRZoomScrollView *currentZoomScrollView;
@property (nonatomic, strong) MRZoomScrollView * lastZoomScrollView;

@end

@implementation PCDStandImgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:5];
    self.showImageArrary = [[NSMutableArray alloc]initWithCapacity:5];
    
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layOut];
}


-(void)initData
{
    for (int i = 0; i < self.arrayOK.count; i ++) {
        
        ShowImage *showImage = [[ShowImage alloc]init];
        showImage.theOrder = i;
        
        showImage.stateOfSelect = YES;
        [self.showImageArrary addObject:showImage];
    }
    ShowImage *showimage = self.showImageArrary[0];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:showimage.button];
}

-(void)layOut{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _btnOK = [[UIButton alloc]initWithFrame:CGRectMake(244,  _scrollerview.frame.size.height - 40, 61, 32)];
    
    _scrollerview.delegate = self;
    _scrollerview.pagingEnabled = YES;
    [_scrollerview setShowsHorizontalScrollIndicator:NO];
    [_scrollerview setShowsVerticalScrollIndicator:NO];
    _scrollerview.contentSize = CGSizeMake((self.arrayOK.count) * (self.view.frame.size.width),0);
    
    _scrollerview.contentOffset = CGPointMake(0 , 0);
    _scrollerview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_scrollerview];
    
    //显示选中的图片的大图
    for (int i=0; i<[self.showImageArrary count]; i++) {
        MRZoomScrollView *zoomScrollView = [[MRZoomScrollView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        CGRect frame = _scrollerview.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        zoomScrollView.zoomScrolleViewDelegate = self;
        zoomScrollView.frame = frame;
        NSArray *imgUrlArr = [self.arrayOK[i] componentsSeparatedByString:@"-"];
        [zoomScrollView loadImageView:[PCD_IMG_URL stringByAppendingString:imgUrlArr[1]]];
        [_scrollerview addSubview:zoomScrollView];
    }
    
    [_scrollerview setContentOffset:CGPointMake(self.view.frame.size.width *self.currentIndex, 0)];
    
    _pageControl = [[UIPageControl alloc]init];
    //    [_pageControl setCenter:CGPointMake(self.view.centerX, self.view.frame.size.height - 50)];
    [_pageControl setFrame:CGRectMake(0, self.view.frame.size.height - 25, self.view.frame.size.width, 25)];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    _pageControl.numberOfPages = self.arrayOK.count;
    _pageControl.currentPage = self.currentIndex;
    [self.view addSubview:_pageControl];
}

#pragma  amrk - scrollViewDelegate
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    self.currentPoint = _scrollerview.contentOffset;
//    int a = self.currentPoint.x   / _scrollerview.frame.size.width + 1 ;
//    self.currentZoomScrollView = scrollView.subviews[a-1];
//    for (int i = 0; i < scrollView.subviews.count; i ++)
//    {
//        MRZoomScrollView * zoomScrollView = scrollView.subviews[i];
//        zoomScrollView.scrollEnabled = NO;
//    }
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPoint = _scrollerview.contentOffset;
    int b = self.currentPoint.x/_scrollerview.frame.size.width + 1 ;
    self.lastZoomScrollView = self.currentZoomScrollView;
    self.currentZoomScrollView = scrollView.subviews[b-1];
    if(![self.lastZoomScrollView isEqual:self.currentZoomScrollView])
    {
        //让滑过去的image恢复默认大小
        float newScale = self.lastZoomScrollView.minimumZoomScale;
        [self.lastZoomScrollView scrollViewDidEndZooming:self.lastZoomScrollView withView:[self.lastZoomScrollView getImageView] atScale:newScale];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:0.2 animations:^{
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        _pageControl.currentPage = index;
    } completion:nil];
    [UIView commitAnimations];
}


#pragma mark - MRZoomSCrollViewDelegate
-(void)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
