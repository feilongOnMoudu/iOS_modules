//
//  DropDownList.h
//  DropDownList
//
//  Created by 宋飞龙 on 16/5/24.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CellSelectBlock)(NSString * userNumber);
typedef void (^DeleateBlock)(NSArray * dataSource);

@interface DropDownList : UIView

@property (nonatomic,strong) CellSelectBlock didSelectBlock;
@property (nonatomic,strong) DeleateBlock deleateBlock;

/**
 *  展示历史记录
 *
 *  @param dataSource     数据源
 *  @param onView         父视图
 *  @param didSelectBlock 选择行回调
 *  @param deleateBlock   删除行回调
 */
+ (void)showDropDownListDataSource:(NSMutableArray *)dataSource
                  onView:(UIView *)onView
          didSelectBlock:(CellSelectBlock)didSelectBlock
            deleateBlock:(DeleateBlock)deleateBlock;

+ (void)removeDropDownList;

@end
