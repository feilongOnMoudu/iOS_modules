//
//  LoginVC.h
//  hschain
//
//  Created by 宋飞龙 on 2017/6/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentedControl.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "BaseVC.h"

@interface LoginVC : BaseVC

@property (weak, nonatomic) IBOutlet LoginView *loginView;
@property (weak, nonatomic) IBOutlet RegisterView *registerView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerViewHeight;
@property (weak, nonatomic) IBOutlet SegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
- (IBAction)bottomClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginViewWidth;

@end
