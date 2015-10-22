

#import <UIKit/UIKit.h>
#import "PcdStandRtnVO.h"
#import "GlobalApp.h"
#import "CommPcdNaviWhere.h"

@interface StandListViewCell : UITableViewCell
{
    UIView *tableLblView;         //标题view
    UIView *tableDataRow;         //数据View;
    UIImageView *standImgView;    //图像View;
    
    UILabel *standCodeLbl;        //店铺模板
    UILabel *siteTmplLbl;         //店铺模板
    UILabel *aktnrLbl;            //档期
    UILabel *operLbl;             //营运课组
    UILabel *puunitLbl;           //U课组
    UILabel *themeLbl;            //主题
    UILabel *pcdTypeLbl;          //促销资源
    
    GlobalApp *globalApp;
    CommPcdNaviWhere *naviWhere;
}

-(void) loadData:(PcdStandRtnVO *)stand;
@end
