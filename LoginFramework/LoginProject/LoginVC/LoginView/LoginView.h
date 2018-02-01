//
//  LoginView.h
//  hschain
//
//  Created by 宋飞龙 on 2017/6/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownList.h"
#import "WLCaptcheButton.h"
#import "HSTextField.h"


typedef void(^SendCode)(WLCaptcheButton * button,NSString * account);
typedef void(^ForgetPassword)(NSString * phoneNumber);
typedef void(^LoginClick)(NSString * account , NSString * password, BOOL loginType);

@interface LoginView : UIView

- (void)removeList;

@property (nonatomic,assign) BOOL dropListShow;//是否显示登录历史
@property (nonatomic,strong) SendCode sendCode;
@property (nonatomic,strong) ForgetPassword forgetPassword;
@property (nonatomic,strong) HSTextField * phoneTextFiled;
@property (nonatomic,strong) UIButton * clickButton;
@property (nonatomic,strong) HSTextField * passwordTextFiled;
@property (nonatomic,strong) UIButton * passwordButton;
@property (nonatomic,strong) UIButton * switchLogin;
@property (nonatomic,strong) WLCaptcheButton * secondButton;
@property (nonatomic,strong) UIButton * forgetButton;
@property (nonatomic,strong) UIButton * loginButton;
@property (nonatomic,strong) LoginClick loginClick;

@end
