
#import <UIKit/UIKit.h>
#import "BasePCDStandNaviController.h"
#import "PCDStandPromoController.h"

@interface PCDStandListController : BasePCDStandNaviController<UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *listView;
    
    PCDStandPromoController *promoCtrl;
    
    UIView *haveNoDataView;
    NSMutableArray *dataArray;
}

-(void)TapHaveNoDataView:(UITapGestureRecognizer *)tap;

@property (nonatomic, strong) PcdStandListRtnVO *StandList;

@end
