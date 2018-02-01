//
//  BaseNavigationController.h
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController <UIViewControllerTransitioningDelegate>

/**
 是否支持设备旋转，需主工程项目设置中打开权限
 */
@property (nonatomic,assign) BOOL autorotation;

@end
