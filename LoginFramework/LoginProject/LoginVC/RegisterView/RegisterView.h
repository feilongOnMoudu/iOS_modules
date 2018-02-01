//
//  RegisterView.h
//  hschain
//
//  Created by 宋飞龙 on 2017/6/21.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCaptcheButton.h"
#import "HSTextField.h"

typedef void(^RegisterClick)(NSString * account,NSString * password,NSString * code);
typedef void(^SendCode)(WLCaptcheButton * button,NSString * account);
typedef void(^LookAgreement)(void);

@interface RegisterView : UIView

@property (nonatomic,strong) SendCode sendCode;
@property (nonatomic,strong) RegisterClick registerClick;
@property (nonatomic,strong) LookAgreement lookAgreement;
@property (nonatomic,strong) HSTextField * phoneTextFiled;
@property (nonatomic,strong) HSTextField * vCodeTextFiled;
@property (nonatomic,strong) HSTextField * passwordTextFiled;
@property (nonatomic,strong) UIButton * passwordButton;
@property (nonatomic,strong) HSTextField * companyNameTextFiled;
@property (nonatomic,strong) UIButton * agreementButton;
@property (nonatomic,strong) UIButton * agreementLabel;
@property (nonatomic,strong) UIButton * registerButton;
@property (nonatomic,strong) WLCaptcheButton * secondButton;
@end
