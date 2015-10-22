
#import <UIKit/UIKit.h>
@class XWAlterview ;
@interface XWAlterview : UIView
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (void)show;
@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
//点击左右按钮都会触发该消失的block
@property (nonatomic, copy) dispatch_block_t dismissBlock;

+(XWAlterview*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle;
@end

