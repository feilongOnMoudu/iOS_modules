//
//  BaseStaticTableVC.h
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BaseStaticTableVCBecomeActive)(void);

@interface BaseStaticTableVC : UITableViewController
/**
 自定义导航左边按钮图片
 
 @param imageName 图片名称
 */
- (void)createLeftItemWithImage:(NSString *)imageName;

/**
 自定义导航右边按钮图片
 
 @param imageName 图片名称
 */
- (void)createRightItemWithImage:(NSString *)imageName;

/**
 自定义导航右边按钮标题
 
 @param title 标题名称
 */
- (void)createRightItemWithTitle:(NSString *)title;

/**
 左边导航按钮点击事件
 */
- (void)leftItemClick;

/**
 右边导航按钮点击事件
 */
- (void)rightItemClick;

/**
 左边导航按钮
 */
@property (nonatomic , strong) UIButton * leftItem;

/**
 右边导航按钮
 */
@property (nonatomic , strong) UIButton * rightItem;

/**
 程序变为活跃状态block
 */
@property (nonatomic , strong) BaseStaticTableVCBecomeActive block;

/**
 程序变为活跃状态回调事件
 
 @param block block
 */
- (void)baseVCBecomeActive:(BaseStaticTableVCBecomeActive)block;
@end
