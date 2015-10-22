//
//  ShowBigViewController.h
//  testKeywordDemo
//
//  Created by mei on 14-8-18.
//  Copyright (c) 2014年 Bluewave. All rights reserved.
//

// 版权属于原作者

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MRZoomScrollView.h"




#pragma mark - showImage

@interface ShowImage : NSObject

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) bool stateOfSelect;
@property (strong, nonatomic) UIButton * button;
@property (assign, nonatomic) int theOrder;



@end

#pragma mark - ShowBigViewController
@interface PCDStandImgViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,MRZoomScrollViewDelegate>
{
    UINavigationBar *mynavigationBar;
     UIImageView    *_imagvtitle;
   
    UIButton        *rightbtn;
    UIScrollView    *_scrollerview;
    UIButton        *_btnOK;
    UIPageControl  *_pageControl;
}
//@property (strong, nonatomic) ShowImage *showImage;
//@property (nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic,strong) NSMutableArray *arrayOK;     //选中的图片数组
@property (nonatomic, assign)NSInteger currentIndex;
@end




