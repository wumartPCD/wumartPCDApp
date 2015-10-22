
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "ComboBoxList.h"
#import "GlobalApp.h"
#import "BasePCDStandNaviController.h"

@interface PCDStandSearchNaviController : BasePCDStandNaviController {
    
    UILabel *siteTmplLabel;
    UILabel *merchCodeLabel;
    UILabel *operLabel;
    UILabel *aktnrLabel;
    UILabel *puunitLabel;
    UILabel *themeLabel;
    UILabel *pcdTypeLabel;
    
    UITextField *merchCodeText;
    
    ComboBoxList *siteTmplCbxList;
    UIButton *siteTmplCbxBtn;
    ComboBoxList *operCbxList;
    UIButton *operCbxBtn;
    ComboBoxList *aktnrCbxList;
    UIButton *aktnrCbxBtn;
    ComboBoxList *puunitCbxList;
    UIButton *puunitCbxBtn;
    ComboBoxList *themeCbxList;
    UIButton *themeCbxBtn;
    ComboBoxList *pcdTypeCbxList;
    UIButton *pcdTypeCbxBtn;
}

@end
