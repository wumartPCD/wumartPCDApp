
#import "BannerImageView.h"

@interface BannerImageView ()

@end

@implementation BannerImageView

@synthesize bounds, imageArr;

+ (id) initWithImages:(CGRect)frameRect items:(NSArray *)images
{
    BannerImageView *banner= [[BannerImageView alloc] initWithImages:frameRect :images];
    return  banner;
}

- (id) initWithImages:(CGRect)frameRect :(NSArray *)images
{
    self = [super initWithFrame:frameRect];
    if (self) {
        bounds = frameRect;
        imageArr = images;
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width,bounds.size.height)];
        [scrollView setPagingEnabled:YES];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [scrollView setDelegate:self];
        [scrollView setBackgroundColor:[UIColor lightGrayColor]];
        
        //ContentSize 这个属性对于UIScrollView挺关键的，取决于是否滚动。
        [scrollView setContentSize:CGSizeMake(CGRectGetWidth(bounds) * [imageArr count], bounds.size.height)];
        [self addSubview:scrollView];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bounds.size.height - 18, bounds.size.width, 18)];
        //[pageControl setBackgroundColor:[UIColor blackColor]];
        [pageControl setBackgroundColor:[UIColor blackColor]];
        [pageControl setAlpha: 0.5];
        
        pageControl.currentPage = 0;
        pageControl.numberOfPages = [imageArr count];
        [pageControl addTarget:self action:@selector(chagePage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        
        viewController = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < [imageArr count]; i++) {
            [viewController addObject:[NSNull null]];
        }
        
        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
        
        [self loadScrollViewPage:0];
        [self loadScrollViewPage:1];
        [self loadScrollViewPage:2];
        [self loadScrollViewPage:3];
        [self loadScrollViewPage:4];
    }
    
    return self;
}

-(void)loadScrollViewPage:(NSInteger)page
{
    if (page >= imageArr.count) {
        return;
    }
    
    UIViewController *imageViewController = [viewController objectAtIndex:page];
    if ((NSNull *)imageViewController == [NSNull null])
    {
        imageViewController = [[UIViewController alloc] init];
        [viewController replaceObjectAtIndex:page withObject:imageViewController];
    }
    
    if (imageViewController.view.superview == nil) {
        CGRect frame = scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        imageViewController.view.frame = frame;
        
        [scrollView addSubview:imageViewController.view];
        
        UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
        titleImage.image = (UIImage *)[imageArr objectAtIndex:page];
        [imageViewController.view addSubview:titleImage];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)uiScrollView
{
    CGFloat pageWidth = CGRectGetWidth(uiScrollView.frame);
    NSInteger page = floor((uiScrollView.contentOffset.x -pageWidth/2)/pageWidth) +1;
    pageControl.currentPage = page;
    
    [self loadScrollViewPage:page-1];
    [self loadScrollViewPage:page];
    [self loadScrollViewPage:page+1];
}

- (void) changePage:(id) sender {
    
    NSInteger page = pageControl.currentPage;
    
    [self loadScrollViewPage:page - 1];
    [self loadScrollViewPage:page];
    [self loadScrollViewPage:page + 1];
    
    CGRect frame = scrollView.frame;
    frame.origin.x = CGRectGetWidth(frame) * page;
    frame.origin.y = 0;
    
    [scrollView scrollRectToVisible:frame animated:YES];
}

-(void)scrollPages {
    ++pageControl.currentPage;
    CGFloat pageWidth = CGRectGetWidth(scrollView.frame);
    if (isFromStart) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        pageControl.currentPage = 0;
    }
    else
    {
        [scrollView setContentOffset:CGPointMake(pageWidth*pageControl.currentPage, scrollView.bounds.origin.y)];
        
    }
    if (pageControl.currentPage == pageControl.numberOfPages - 1) {
        isFromStart = YES;
    }
    else
    {
        isFromStart = NO;
    }
}

@end
