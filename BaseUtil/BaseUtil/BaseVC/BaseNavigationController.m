//
//  BaseNavigationController.m
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "BaseNavigationController.h"
#import "PresentAnimated.h"
#import "DissmissAnimated.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.transitioningDelegate = self;
    self.tabBarController.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentAnimated alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DissmissAnimated alloc] init];
}

-(BOOL)shouldAutorotate {
    return self.autorotation;
}

@end
