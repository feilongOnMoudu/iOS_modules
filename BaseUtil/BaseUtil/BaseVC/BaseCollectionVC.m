//
//  BaseCollectionVC.m
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "BaseCollectionVC.h"
#import "HSChainRefreshBlue.h"
#import "HSChainRefreshWhite.h"
#import "RefreshFooter.h"

@interface BaseCollectionVC ()
//当前页码
@property (nonatomic , assign) int pageNumber;
//当前页容量
@property (nonatomic , assign) int pageSize;
//表格视图
@property (strong, nonatomic) UICollectionView * collectionView;

@end

@implementation BaseCollectionVC
@synthesize collectionDataSource;
@synthesize selectedCellIndex;
@synthesize pageNumber;
@synthesize pageSize;
@dynamic collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedCellIndex = -1;
    self.pageSize = CUSTOM_PAGE_SIZE;
    //下拉刷新
    [self addHeader];
    //上拉加载更多
    [self addFooter];
    [self.collectionView.mj_header beginRefreshing];
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

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)addHeader {
    __weak UICollectionView *collectionV = self.collectionView;
    collectionV.mj_header = [HSChainRefreshBlue headerWithRefreshingBlock:^{
        [self getNewPageList];
    }];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)addFooter {
    __weak UICollectionView *collectionV = self.collectionView;
    collectionV.mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        [self getNextPageList];
    }];
    self.collectionView.mj_footer.hidden = YES;
}

//得到最新一页的列表
- (void)getNewPageList {
    [collectionDataSource removeAllObjects];
    selectedCellIndex = -1;
    pageNumber = 1;
    [self getPageList:GET_PAGE_FLAG_NEW];
}

//得到下一页的列表
- (void)getNextPageList {
    pageNumber = pageNumber + 1;
    [self getPageList:GET_PAGE_FLAG_NEXT];
}

//得到分页列表
-(void)getPageList:(NSString*) flag {
    //刷新列表
    [self refreshTable:nil byFlag:flag];
}

//刷新表格
- (void)refreshTable:(NSMutableArray*) dataSource byFlag:(NSString *)flag {
    if ([flag isEqualToString:GET_PAGE_FLAG_NEW]) {
        if (dataSource != nil) {
            self.collectionDataSource = dataSource;
            [self.collectionView reloadData];
            //结束刷新
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
        }
    } else {
        if (dataSource != nil) {
            [self.collectionDataSource addObjectsFromArray:dataSource];
            [self.collectionView reloadData];
            //结束刷新
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
        }
    }
}

- (void)didEnterBackground:(NSNotification *) notification {
    self.collectionView.hidden = YES;
}

- (void)didBecomeActive:(NSNotification *) notification {
    self.collectionView.hidden = NO;
}

-(NSString*)pageNumberString {
    return [NSString stringWithFormat:@"%d", self.pageNumber];
}

-(NSString*)pageSizeString {
    return [NSString stringWithFormat:@"%d", self.pageSize];
}

@end
