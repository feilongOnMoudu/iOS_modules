//
//  BaseStaticTableVC.m
//  BaseUtil
//
//  Created by 宋飞龙 on 2018/1/25.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "BaseStaticTableVC.h"

@interface BaseStaticTableVC ()

@end

@implementation BaseStaticTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self                                               selector:@selector(appDidBecomeActive)  name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)createLeftItemWithImage:(NSString *)imageName {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(-10, 0, 30, 30);
    [btn addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    UIBarButtonItem *leftBarButon = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if(([UIDevice currentDevice].systemVersion.floatValue>=7.0?20:0)) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButon];
    } else {
        self.navigationItem.leftBarButtonItem = leftBarButon;
    }
    self.leftItem = btn;
}

- (void)createRightItemWithImage:(NSString *)imageName {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    btn.imageView.tintColor = [UIColor whiteColor];
    [btn setAdjustsImageWhenHighlighted:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.rightItem = btn;
}

- (void)createRightItemWithTitle:(NSString *)title {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 30);
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightItem = btn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)leftItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemClick {
    
}

- (void)baseVCBecomeActive:(BaseStaticTableVCBecomeActive)block {
    self.block = block;
}

- (void)appDidBecomeActive {
    [self.view endEditing:YES];
    if (self.block) {
        self.block();
    }
}

@end
