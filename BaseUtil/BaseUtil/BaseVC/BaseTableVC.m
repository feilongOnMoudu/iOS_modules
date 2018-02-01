//
//  BaseTableVC.m
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "BaseTableVC.h"
#import "HSChainRefreshBlue.h"
#import "HSChainRefreshWhite.h"
#import "RefreshFooter.h"


@interface BaseTableVC ()
//当前页码
@property (nonatomic , assign) int pageNumber;
//当前页容量
@property (nonatomic , assign) int pageSize;
//表格视图
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation BaseTableVC
@synthesize tableDataSource;
@synthesize selectedCellIndex;
@synthesize pageNumber;
@synthesize pageSize;
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedCellIndex = -1;
    self.pageSize = CUSTOM_PAGE_SIZE;
    self.pageNumber = 1;
    ///<1>.下拉刷新
    [self addHeader];
    ///<2>.上拉加载更多
    [self addFooter];
    //自动刷新(一进入程序就下拉刷新)
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //监听消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground:) name:@"APP_DID_ENTER_BACKGROUND" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive:) name:@"APP_DID_BECOME_ACTIVE" object:nil];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc {
    NSLog(@"BaseTableVC--dealloc---");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)addHeader {
    __weak UITableView *tableV = self.tableView;
    tableV.mj_header = [HSChainRefreshBlue headerWithRefreshingBlock:^{
        [self getNewPageList];
    }];
    tableV.mj_header.automaticallyChangeAlpha = YES;
}

- (void)addFooter {
    __weak UITableView *tableV = self.tableView;
    tableV.mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        [self getNextPageList];
    }];
}

- (void)getNewPageList {
    [tableDataSource removeAllObjects];
    selectedCellIndex = -1;
    pageNumber = 1;
    [self getPageList:GET_PAGE_FLAG_NEW];
}

- (void)getNextPageList {
    pageNumber = pageNumber + 1;
    [self getPageList:GET_PAGE_FLAG_NEXT];
}

-(void)getPageList:(NSString*) flag {
    [self refreshTable:nil byFlag:flag];
}

- (void)refreshTable:(NSMutableArray*) dataSource byFlag:(NSString *)flag {
    if ([flag isEqualToString:GET_PAGE_FLAG_NEW]) {
        if (dataSource != nil) {
            self.tableDataSource = dataSource;
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } else {
            NSLog(@"加载完成");
        }
    } else {
        if (dataSource != nil) {
            [self.tableDataSource addObjectsFromArray:dataSource];
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } else {
            NSLog(@"加载完成");
        }
    }
}

- (void)didEnterBackground:(NSNotification *) notification {
    self.tableView.hidden = YES;
}

- (void)didBecomeActive:(NSNotification *) notification {
    self.tableView.hidden = NO;
}

-(NSString*)pageNumberString {
    return [NSString stringWithFormat:@"%d", self.pageNumber];
}

-(NSString*)pageSizeString {
    return [NSString stringWithFormat:@"%d", self.pageSize];
}

@end
