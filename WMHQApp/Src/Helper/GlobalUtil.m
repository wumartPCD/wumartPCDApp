//
//  GlobalUtil.m
//  LBSMap
//
//  Created by 杨淑园 on 15/8/4.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "GlobalUtil.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

//#import "SSKeychain.h"
//#import "TKAlertCenter.h"
//#import "TKAlertCenter.h"
@implementation GlobalUtil

#pragma mark 判断是否有网络
+(BOOL)networkIsPing
{
    /*监测网络状态*/
    BOOL isServerAvailable = NO;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    if (([reachability connectionRequired]) || (NotReachable == reachability.currentReachabilityStatus)) {
        isServerAvailable = NO;
        
    } else if((ReachableViaWiFi == reachability.currentReachabilityStatus) || (ReachableViaWWAN == reachability.currentReachabilityStatus)){
        isServerAvailable = YES;
    }
    
    return isServerAvailable;
}


+(void)ShowHudWithMeassage:(NSString *)message toController:(UIView *)view delay:(NSTimeInterval)delay
{
    MBProgressHUD  *hud = [[MBProgressHUD alloc]init];
    hud.labelText = message;
    [view insertSubview:hud aboveSubview:view.subviews.lastObject];
    hud.labelFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}


+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

+(void)upLoadImages:(NSArray *)images
{
//    
//    for(int i =0 ; i< images.count;i ++)
//    {
//        UIImage *image = images[i];
////        将图片转为base64位字符串
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
//        NSString *encodedImageStr = [data base64Encoding];
//        
//
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"url"]];
//        NSDictionary * para = @{@"imageBase64":encodedImageStr};
//        
//        AFHTTPRequestOperation *op1 = [manager POST:@"url" parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            NSLog(@"上传成功");
//        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//            NSLog(@"上传失败");
//        }];
//        [op1 start];
    
        //上传图片 以文件流的格式
//    AFHTTPRequestOperation *op = [manager POST:@"url" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//
//        
//        NSData *imageData = UIImageJPEGRepresentation(image, 1);
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//        
//        // 上传图片，以文件流的格式
//        [formData appendPartWithFileData:imageData name:@"myfiles" fileName:fileName mimeType:@"image/png"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"上传图片成功");
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"图片上传失败");
//    }];
//    [op start];
//    }


}


+(UIView *)FindFirstResponder:(UIView *)view
{
    if (view.isFirstResponder) {
        return view;
    }
    for (UIView *subView in view.subviews) {
        UIView *firstResponder = [GlobalUtil FindFirstResponder:subView];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}


+(NSArray *)ExchangeDataToArray:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return nil;
    }
    
    NSCharacterSet *set =[NSCharacterSet characterSetWithCharactersInString:@","];
    NSMutableArray * array = [NSMutableArray arrayWithArray:[string componentsSeparatedByCharactersInSet:set]];
    if([array[0] isEqualToString:@"#"])
    {
        array[0] = @"";
//        [array removeObject:array[0]];
    }
    return  array;
}


@end
