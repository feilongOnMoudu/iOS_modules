//
//  BaseCollectionVC.h
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "BaseVC.h"

@interface BaseCollectionVC : BaseVC <UICollectionViewDelegate,UICollectionViewDataSource>

/**
 表格数据源
 */
@property (nonatomic , strong) NSMutableArray *collectionDataSource;

/**
 选中的单元格序号
 */
@property (nonatomic , assign) int selectedCellIndex;

/**
 当前页码
 */
@property (nonatomic, copy) NSString *pageNumberString;

/**
 当前页容量
 */
@property (nonatomic, copy) NSString *pageSizeString;

/**
 得到分页列表
 
 @param flag 分页列表标识
 */
-(void)getPageList:(NSString*)flag;

/**
 刷新表格
 
 @param dataSource  数据源
 @param flag        分页列表标识
 */
-(void)refreshTable:(NSMutableArray*) dataSource byFlag:(NSString *)flag;

/**
 下拉刷新
 */
-(void)addHeader;

/**
 上拉加载更多
 */
-(void)addFooter;
@end
