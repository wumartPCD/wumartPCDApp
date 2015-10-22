
#import <UIKit/UIKit.h>

@protocol ComboBoxButtonDelegate;
@interface ComboBoxButton : UIView <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tv;//下拉列表
    BOOL showList;//是否弹出下拉列表
}

@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UIButton *btn;
@property (nonatomic,assign) NSUInteger showRowCount;

-(void)closeDropdown;
    
@property (nonatomic, assign) id <ComboBoxButtonDelegate> delegate;

@end

@protocol ComboBoxButtonDelegate <NSObject>
@optional

- (void)launch:(int)index;

@end

