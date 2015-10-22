//
//  GlobalUtil.h
//  LBSMap
//
//  Created by 杨淑园 on 15/8/4.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalUtil : NSObject

//是否有网络
+(BOOL)networkIsPing;

+(void)ShowHudWithMeassage:(NSString *)message toController:(UIView *)view delay:(NSTimeInterval)delay;

//图片压缩到指定大小
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

//上传图片
+(void)upLoadImages:(NSArray *)images;


+(UIView *)FindFirstResponder:(UIView *)view;

+(NSArray *)ExchangeDataToArray:(NSString *)string;

@end
