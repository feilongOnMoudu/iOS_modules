//
//  RegisterView.m
//  hschain
//
//  Created by 宋飞龙 on 2017/6/21.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import <LoginFramework/RegisterView.h>

#define Login_Width ([UIScreen mainScreen].bounds.size.width)
#define Login_Height ([UIScreen mainScreen].bounds.size.height)

#define Login_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define Login_RGB(r,g,b) Login_RGBA(r,g,b,1.0f)

@interface RegisterView ()<UITextFieldDelegate> {
    BOOL readCheck;
    BOOL passwordHidden;//是否明文显示密码
}

@end

@implementation RegisterView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self createPhoneTextFiled];
    [self createvCodeTextFiled];
    [self createPasswordTextFiled];
    [self createPasswordButton];
    //[self createCompanyNameTextFiled];
    [self createAgreementView];
    [self createRegisterButton];
    [self textChange];
}

- (void)textChange {
    [self.phoneTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit|UIControlEventEditingDidEnd|UIControlEventEditingChanged];
    [self.vCodeTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit|UIControlEventEditingDidEnd|UIControlEventEditingChanged];
    [self.passwordTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit|UIControlEventEditingDidEnd|UIControlEventEditingChanged];
    [self.companyNameTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit|UIControlEventEditingDidEnd|UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (self.phoneTextFiled.text.length == 11 &&
        self.vCodeTextFiled.text.length == 4 &&
        self.passwordTextFiled.text.length >=4) {
        self.registerButton.backgroundColor = Login_RGB(255, 255, 255);
    } else {
        self.registerButton.backgroundColor = Login_RGB(255, 255, 255);
    }
}

- (void)createPhoneTextFiled {
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 18, 18)];
    img.image = [UIImage imageNamed:@"icon_phone"];
    [leftView addSubview:img];
    
    
    self.phoneTextFiled = [[HSTextField alloc] initWithFrame:CGRectMake(0, 0, Login_Width-30-30, 50)];
    self.phoneTextFiled.delegate = self;
    self.phoneTextFiled.backgroundColor = [UIColor clearColor];
    self.phoneTextFiled.font = [UIFont systemFontOfSize:15];
    self.phoneTextFiled.placeholder = @"请输入手机号码";
    self.phoneTextFiled.textColor = [UIColor whiteColor];
    //[ProjectUtil textField:self.phoneTextFiled placeholderFont:15 color:Login_RGB(189, 201, 255)];
    self.phoneTextFiled.leftView = leftView;
    self.phoneTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    //[ZZLimitInputManager limitPhoneInputView:self.phoneTextFiled];
    [self addSubview:self.phoneTextFiled];
    UIView * lineView= [[UIView alloc] initWithFrame:CGRectMake(0, 50, Login_Width-30, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
}

- (void)createvCodeTextFiled {
    
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 18, 18)];
    img.image = [UIImage imageNamed:@"icon_code"];
    [leftView addSubview:img];
    
    self.secondButton = [[WLCaptcheButton alloc] initWithFrame:CGRectMake(0, 10, 84, 30)];
    [self.secondButton setTitleColor:Login_RGB(56, 75, 159) forState:UIControlStateNormal];
    self.secondButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.secondButton.backgroundColor = Login_RGB(255, 255, 255);
    [self.secondButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.secondButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.vCodeTextFiled = [[HSTextField alloc] initWithFrame:CGRectMake(0, 50, Login_Width-30, 50)];
    self.vCodeTextFiled.delegate = self;
    self.vCodeTextFiled.backgroundColor = [UIColor clearColor];
    self.vCodeTextFiled.placeholder = @"请输入验证码";
    self.vCodeTextFiled.font = [UIFont systemFontOfSize:15];
    self.vCodeTextFiled.textColor = [UIColor whiteColor];
    //[ProjectUtil textField:self.vCodeTextFiled placeholderFont:15 color:Login_RGB(189, 201, 255)];
    self.vCodeTextFiled.leftView = leftView;
    self.vCodeTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.vCodeTextFiled.rightView = self.secondButton;
    self.vCodeTextFiled.rightViewMode = UITextFieldViewModeAlways;
    //[ZZLimitInputManager limitInputView:self.vCodeTextFiled maxLength:4];
    self.vCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.vCodeTextFiled];
    UIView * lineView= [[UIView alloc] initWithFrame:CGRectMake(0, 100, Login_Width-30, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
}

- (void)sendCode:(UIButton *)button {
    if (self.phoneTextFiled.text.length == 0 ) {
       // [AlertUtil alertWarning:@"账户名不能为空" toView:WINDOWS];
        return;
    }
    if (self.phoneTextFiled.text.length != 11 ) {
        //[AlertUtil alertWarning:@"账户名不正确" toView:WINDOWS];
        return;
    }
    if (self.sendCode) {
        self.sendCode(self.secondButton,self.phoneTextFiled.text);
    }
//    if ([ProjectUtil isNeedAuthWhenAppRun_time:SMSCODE_TIME key:KEY_APP_REGISTER_SEND_SMSCODE]) {
//        if (self.sendCode) {
//            self.sendCode(self.secondButton,self.phoneTextFiled.text);
//        }
//    } else {
//        //[self.secondButton startTime:KEY_APP_REGISTER_SEND_SMSCODE];
//    }
}

- (void)createPasswordTextFiled {
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 18, 18)];
    img.image = [UIImage imageNamed:@"icon_password"];
    [leftView addSubview:img];
    
    
    self.passwordTextFiled = [[HSTextField alloc] initWithFrame:CGRectMake(0, 100, Login_Width-30-30, 50)];
    self.passwordTextFiled.delegate = self;
    self.passwordTextFiled.backgroundColor = [UIColor clearColor];
    self.passwordTextFiled.placeholder = @"请输入密码(6-16位字母和数字)";
    self.passwordTextFiled.textColor = [UIColor whiteColor];
    self.passwordTextFiled.secureTextEntry = YES;
    self.passwordTextFiled.font = [UIFont systemFontOfSize:15];
    //[ProjectUtil textField:self.passwordTextFiled placeholderFont:15 color:Login_RGB(189, 201, 255)];
    self.passwordTextFiled.keyboardType = UIKeyboardTypeAlphabet;
//#if DEBUG
//    [ZZLimitInputManager limitInputView:self.passwordTextFiled maxLength:10];
//#else
//    [ZZLimitInputManager limitInputView:self.passwordTextFiled regX:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"];
//#endif
    self.passwordTextFiled.leftView = leftView;
    self.passwordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:self.passwordTextFiled];
    UIView * lineView= [[UIView alloc] initWithFrame:CGRectMake(0, 150, Login_Width-30, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
}

- (void)createPasswordButton {
    self.passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.passwordButton.frame = CGRectMake(Login_Width-30-30, 100, 30, 50);
    [self.passwordButton setImage:[UIImage imageNamed:@"icon_eye_hide"] forState:UIControlStateNormal];
    self.passwordButton.backgroundColor = [UIColor clearColor];
    [self.passwordButton setTitleColor:Login_RGB(211, 211, 211) forState:UIControlStateNormal];
    [self.passwordButton addTarget:self action:@selector(passwordHidden:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.passwordButton];
}

- (void)passwordHidden:(UIButton *)button {
    passwordHidden = !passwordHidden;
    if (passwordHidden) {
        [self.passwordButton setImage:[UIImage imageNamed:@"icon_eye_show"] forState:UIControlStateNormal];
        self.passwordTextFiled.secureTextEntry = NO;
    } else {
        [self.passwordButton setImage:[UIImage imageNamed:@"icon_eye_hide"] forState:UIControlStateNormal];
        self.passwordTextFiled.secureTextEntry = YES;
    }
}

- (void)createCompanyNameTextFiled {
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 18, 18)];
    img.image = [UIImage imageNamed:@"icon_companyname"];
    [leftView addSubview:img];
    
    
    self.companyNameTextFiled = [[HSTextField alloc] initWithFrame:CGRectMake(0, 150, Login_Width-30-30, 50)];
    self.companyNameTextFiled.delegate = self;
    self.companyNameTextFiled.backgroundColor = [UIColor clearColor];
    self.companyNameTextFiled.placeholder = @"请填写所在企业名称";
    self.companyNameTextFiled.textColor = [UIColor whiteColor];
    self.companyNameTextFiled.font = [UIFont systemFontOfSize:15];
    //[ProjectUtil textField:self.companyNameTextFiled placeholderFont:15 color:Login_RGB(189, 201, 255)];
    self.companyNameTextFiled.leftView = leftView;
    self.companyNameTextFiled.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:self.companyNameTextFiled];
    UIView * lineView= [[UIView alloc] initWithFrame:CGRectMake(0, 200, Login_Width-30, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
}

- (void)createAgreementView {
    self.agreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreementButton.frame = CGRectMake(0, 170, 130, 18);
    [self.agreementButton setImage:[UIImage imageNamed:@"icon_checkbox_nor"] forState:UIControlStateNormal];
    [self.agreementButton setTitle:@"我已阅读并同意" forState:UIControlStateNormal];
    self.agreementButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.agreementButton.backgroundColor = [UIColor clearColor];
    [self.agreementButton setTitleColor:Login_RGB(189, 201, 255) forState:UIControlStateNormal];
    self.agreementButton.tag = 1;
    [self addSubview:self.agreementButton];
    self.agreementLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreementLabel.frame = CGRectMake(130, 170, Login_Width-30-130, 18);
    self.agreementLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.agreementLabel setTitle:@"《链花生注册协议》" forState:UIControlStateNormal];
    self.agreementLabel.titleEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
    self.agreementLabel.tag = 2;
    [self addSubview:self.agreementLabel];
    self.agreementLabel.titleLabel.font = self.agreementButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.agreementButton addTarget:self action:@selector(readCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreementLabel addTarget:self action:@selector(lookAgreementClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)lookAgreementClick {
    if (self.lookAgreement) {
        self.lookAgreement();
    }
}

- (void)readCheck:(UIButton *)button {
    readCheck = !readCheck;
    if (readCheck) {
        [self.agreementButton setImage:[UIImage imageNamed:@"icon_checkbox_sel"] forState:UIControlStateNormal];
        
    } else {
        [self.agreementButton setImage:[UIImage imageNamed:@"icon_checkbox_nor"] forState:UIControlStateNormal];
    }
}

- (void)createRegisterButton {
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake(0, 208, Login_Width-30, 50);
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.registerButton.backgroundColor = Login_RGB(255, 255, 255);
   // [ProjectUtil cutRoundCornerView:self.registerButton cornerRadius:8];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:Login_RGB(56, 75, 159) forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.registerButton];
}

- (void)registerClick:(UIButton *)button {
    if (self.phoneTextFiled.text.length == 0 ) {
        //[AlertUtil alertWarning:@"账户名不能为空" toView:WINDOWS];
        return;
    }
    if (self.phoneTextFiled.text.length != 11 ) {
        //[AlertUtil alertWarning:@"账户名不正确" toView:WINDOWS];
        return;
    }
    if (self.vCodeTextFiled.text.length == 0 ) {
        //[AlertUtil alertWarning:@"验证码不能为空" toView:WINDOWS];
        return;
    }
    if (self.vCodeTextFiled.text.length != 4 ) {
        //[AlertUtil alertWarning:@"验证码不正确" toView:WINDOWS];
        return;
    }
    if (self.passwordTextFiled.text.length == 0) {
        //[AlertUtil alertWarning:@"密码不能为空" toView:WINDOWS];
        return;
    }
//    if (self.companyNameTextFiled.text.length ==0) {
//        [AlertUtil alertWarning:@"企业名称不能为空" toView:WINDOWS];
//        return;
//    }
    if (self.registerClick) {
        if (!readCheck) {
            //[AlertUtil alertError:@"请先同意协议" toView:WINDOWS];
        } else {
           self.registerClick(self.phoneTextFiled.text,self.passwordTextFiled.text,self.vCodeTextFiled.text);
        }
    }
}

@end
