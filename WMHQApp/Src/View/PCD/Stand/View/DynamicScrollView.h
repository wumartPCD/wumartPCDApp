//
//  DynamicScrollView.h
//  MeltaDemo
//
//  Created by hejiangshan on 14-8-27.
//  Copyright (c) 2014年 hejiangshan. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@protocol DynamicScrollViewDelegate <NSObject>

-(void)ShowBigPicture:(NSInteger)index;
-(void)DeletePicFromService:(NSInteger)index;

@end


@interface DynamicScrollView : UIView<UIGestureRecognizerDelegate,UIScrollViewDelegate>

//- (id)initWithFrame:(CGRect)frame withImages:(NSMutableArray *)images;

@property(nonatomic,retain)UIScrollView *myScrollView;
//@property (nonatomic, strong)UIPageControl *pageControl;

@property(nonatomic,retain)NSMutableArray *images;

@property(nonatomic,retain)NSMutableArray *imageViews;

@property(nonatomic,assign)BOOL isDeleting;

@property (nonatomic, assign)id<DynamicScrollViewDelegate> delegate;


-(void)ConfigData:(NSMutableArray *)images;
//添加一个新图片
//- (void)addImageView:(NSString *)imageName;

@end
