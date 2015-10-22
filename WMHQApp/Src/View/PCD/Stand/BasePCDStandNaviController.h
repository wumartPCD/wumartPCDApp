
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "ComboBoxButton.h"
#import "ComboBoxList.h"
#import "GlobalApp.h"
#import "EnumConst.h"
#import "CommPcdNaviWhere.h"
#import "PcdStandListRtnVO.h"

@interface BasePCDStandNaviController : BasePortraitController<ComboBoxButtonDelegate> {
    
    GlobalApp *globalApp;
    CommPcdNaviWhere *naviWhere;
    
    NSInteger curBtnTag;
    ComboBoxList *commCbxList;
    
    int curPageNo;
}

-(CommPcdNaviWhere *)getNaviWhere:(BOOL)isFirstBlank;

- (BOOL)searchNaviWhere:(BOOL)isFirstBlank funcNo:(NSString *)funcNo;

- (PcdStandListRtnVO *) commSearchPcdStand:(BOOL)isFirstBlank;
    
- (void) onComboBoxBtnClick:(id) sender;

@end
