
#import "PCDStandListController.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "EnumConst.h"
#import "GlobalApp.h"

#import "StandListViewCell.h"
#import "PCDStandPromoController.h"
#import "UIView+Frame.h"
#import "XMLHandleHelper.h"
#import "PcdStandRtnVO.h"
#import "StandListViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

@implementation PCDStandListController

@synthesize StandList;

- (id)init
{
    self = [super init];
    if (self) {
        globalApp=[GlobalApp sharedInstance];
        dataArray = [[NSMutableArray alloc]initWithCapacity:5];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    curPageNo = 1;
    
    naviWhere = [self getNaviWhere:TRUE];
    
    UINavigationItem *navigationItem = [super showNavigationBar:@"陈列标准列表" isLandscape:FALSE showBackBtn:TRUE];
    
    UIImage *launcherImage=[UIImage imageNamed:@"btn_title_search"];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:launcherImage forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake([self getScreenWidth]-55, 0, 48, 38)];
    [rightBtn addTarget:self action:@selector(onSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *showLauncher = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    navigationItem.rightBarButtonItem = showLauncher;
    
    [self showMainView];
    [self loadData];
}

- (void)onBackBtnClick: (id) sender {
    [super onBackBtnClick:sender];
}

- (void) onSearchBtnClick:(id)sender{
    [super onBackBtnClick:sender];
}

-(void)refreshView
{
    StandList = [self commSearchPcdStand:TRUE];
    if (StandList == Nil || StandList.PcdStandList.count==0) {
        [listView.footer endRefreshingWithNoMoreData];
        return;
    }
    else
    {
        curPageNo++;
        [self loadData];
    }
}

-(void)loadData
{
    [dataArray addObjectsFromArray:StandList.PcdStandList];
    listView.hidden = NO;
    [listView reloadData];
}

-(void)showMainView
{
    listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 51, [self getScreenWidth], [self getScreenHeight]-51)];
    listView.delegate = self;
    listView.dataSource = self;
    [self.view addSubview:listView];
    
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PushDownRefresh)];
    listView.header = header;
    listView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(PushUpLoadMoreData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
}

-(void)PushDownRefresh
{
    [listView.header beginRefreshing];
    [listView.header endRefreshing];
}

-(void)PushUpLoadMoreData
{
    [listView.footer beginRefreshing];
    [self refreshView];
    [listView.footer endRefreshing];
}

-(void)TapHaveNoDataView:(UITapGestureRecognizer *)tap
{
    UILabel *label = haveNoDataView.subviews[0];
    label.text = @"";
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    hud.labelText = @"正在刷新";
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
    
    [self refreshView];
}

#pragma  maek - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    StandListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[StandListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell loadData:dataArray[indexPath.row]];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PcdStandRtnVO *stand= dataArray[indexPath.row];
    
    promoCtrl=[[PCDStandPromoController alloc] init];
    promoCtrl.IsReadonly = READ_ONLY_TRUE;
    promoCtrl.StandNo = stand.StandNo;
    promoCtrl.naviWhere = naviWhere;
    
    [self.navigationController pushViewController:promoCtrl animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127;
}

@end
