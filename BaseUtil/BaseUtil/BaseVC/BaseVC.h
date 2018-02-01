//
//  BaseVC.h
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>

//页容量
#define CUSTOM_PAGE_SIZE 10
//得到分页列表标识：得到第一页
extern NSString * const GET_PAGE_FLAG_NEW;
//得到分页列表标识：得到下一页
extern NSString * const GET_PAGE_FLAG_NEXT;

typedef void(^BaseVCBecomeActive)(void);

@interface BaseVC : UIViewController<UIViewControllerTransitioningDelegate>

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
 是否支持设备旋转，需主工程项目设置中打开权限
 */
@property (nonatomic,assign) BOOL autorotation;

/**
 程序变为活跃状态block
 */
@property (nonatomic , strong) BaseVCBecomeActive block;

/**
 程序变为活跃状态回调事件

 @param block block
 */
- (void)baseVCBecomeActive:(BaseVCBecomeActive)block;

@end
