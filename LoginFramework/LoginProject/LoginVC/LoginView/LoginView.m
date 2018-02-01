//
//  LoginView.m
//  hschain
//
//  Created by 宋飞龙 on 2017/6/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import <LoginFramework/LoginView.h>

#define Login_Width ([UIScreen mainScreen].bounds.size.width)
#define Login_Height ([UIScreen mainScreen].bounds.size.height)

#define Login_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define Login_RGB(r,g,b) Login_RGBA(r,g,b,1.0f)

@interface LoginView () {
    NSMutableArray * dataArr;//账号登录历史
    BOOL passwordHidden;//是否明文显示密码
    BOOL loginType;//登录类型
}

@end

@implementation LoginView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}

- (void)getData {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accounthistory"]) {
        dataArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"accounthistory"]];
        if (dataArr.count>0) {
            self.clickButton.userInteractionEnabled = YES;
        } else {
            self.clickButton.userInteractionEnabled = NO;
        }
    } else {
        self.clickButton.userInteractionEnabled = NO;
    }
}

- (void)createUI {
    dataArr =[NSMutableArray array];
    //账号
    [self createAccountTextFiledView];
    //历史记录
    [self createClickButton];
    //密码
    [self createpasswordTextFiled];
    //密码明暗文
    [self createPasswordButton];
    //切换登录类型
    [self switchLoginType];
    //忘记密码
    [self createForgetPassword];
    //登录按钮
    [self createLoginButton];
    [self textChange];
    [self getData];
}

- (void)textChange {
    [self.phoneTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit|UIControlEventEditingDidEnd|UIControlEventEditingChanged];
    [self.passwordTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit|UIControlEventEditingDidEnd|UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (self.phoneTextFiled.text.length == 11 &&
        self.passwordTextFiled.text.length >=4 ) {
        self.loginButton.backgroundColor = Login_RGB(255, 255, 255);
    } else {
        self.loginButton.backgroundColor = Login_RGB(255, 255, 255);
    }
}

- (void)dropList:(UIButton *)button {
    self.dropListShow = !self.dropListShow;
    if (self.dropListShow) {
        [button setImage:[UIImage imageNamed:@"icon_arrow_up"] forState:UIControlStateNormal];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Login_Width-30, 100+ 50 * dataArr.count);
        [DropDownList showDropDownListDataSource:dataArr onView:self didSelectBlock:^(NSString *userNumber) {
            self.phoneTextFiled.text = userNumber;
            [self removeList];
        } deleateBlock:^(NSArray *dataSource) {
                    [[NSUserDefaults standardUserDefaults] setObject:dataSource forKey:@"accounthistory"];
                    if (dataSource.count == 0) {
                        [DropDownList removeDropDownList];
                        [button setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
                        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Login_Width-30, 110);
                        button.userInteractionEnabled = NO;
                    }else {
                        button.userInteractionEnabled = YES;
                        [button setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
                        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Login_Width-30, 100+ 50 * dataArr.count);
                    }
        }];
    } else {
        [self removeList];
        [button setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    }
}

- (void)removeList {
    self.dropListShow = NO;
    [self endEditing:YES];
    [DropDownList removeDropDownList];
    [self.clickButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Login_Width-30, 230);
}

- (void)createClickButton {
    self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickButton.frame = CGRectMake(Login_Width-30-30, 0, 30, 50);
    [self.clickButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.clickButton.backgroundColor = [UIColor clearColor];
    [self.clickButton setTitleColor:Login_RGB(211, 211, 211) forState:UIControlStateNormal];
    [self.clickButton addTarget:self action:@selector(dropList:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clickButton];
}

- (void)createPasswordButton {
    self.passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.passwordButton.frame = CGRectMake(Login_Width-30-30, 60, 30, 50);
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

- (void)createAccountTextFiledView {
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 18, 18)];
    img.image = [UIImage imageNamed:@"icon_phone"];
    [leftView addSubview:img];

    
    self.phoneTextFiled = [[HSTextField alloc] initWithFrame:CGRectMake(0, 0, Login_Width-30, 50)];
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

- (void)createpasswordTextFiled {
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 18, 18)];
    img.image = [UIImage imageNamed:@"icon_password"];
    [leftView addSubview:img];
    
    self.passwordTextFiled = [[HSTextField alloc] initWithFrame:CGRectMake(0, 60, Login_Width-30, 50)];
    self.passwordTextFiled.backgroundColor = [UIColor clearColor];
    self.passwordTextFiled.placeholder = @"请输入登录密码";
    self.passwordTextFiled.font = [UIFont systemFontOfSize:15];
    self.passwordTextFiled.secureTextEntry = YES;
    self.passwordTextFiled.textColor = [UIColor whiteColor];
    //[ProjectUtil textField:self.passwordTextFiled placeholderFont:15 color:Login_RGB(189, 201, 255)];
    self.passwordTextFiled.leftView = leftView;
    self.passwordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextFiled.keyboardType = UIKeyboardTypeAlphabet;
    [self addSubview:self.passwordTextFiled];
//#if DEBUG
//    [ZZLimitInputManager limitInputView:self.passwordTextFiled maxLength:10];
//#else
//    [ZZLimitInputManager limitInputView:self.passwordTextFiled regX:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"];
//#endif
    UIView * lineView= [[UIView alloc] initWithFrame:CGRectMake(0, 109, Login_Width-30, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
}

- (void)switchLoginType {
    self.switchLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.switchLogin.frame = CGRectMake(0, 110, 150, 50);
    self.switchLogin.titleLabel.font = [UIFont systemFontOfSize:15];
    self.switchLogin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.switchLogin setTitle:@"短信验证码登录" forState:UIControlStateNormal];
    [self.switchLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.switchLogin addTarget:self action:@selector(switchLoginType:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.switchLogin];
    
    self.secondButton = [[WLCaptcheButton alloc] initWithFrame:CGRectMake(0, 10, 84, 30)];
    [self.secondButton setTitleColor:Login_RGB(56, 75, 159) forState:UIControlStateNormal];
    self.secondButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.secondButton.backgroundColor = Login_RGB(255, 255, 255);
    self.secondButton.identifyKey = @"Login_sendSms";
    [self.secondButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.secondButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createForgetPassword {
    self.forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetButton.frame = CGRectMake(Login_Width-30-100, 110, 100, 50);
    [self.forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.forgetButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(forgetButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.forgetButton];
}

- (void)forgetButton:(UIButton *)button {
    if (self.forgetPassword) {
        self.forgetPassword(self.phoneTextFiled.text);
    }
}

- (void)switchLoginType:(UIButton *)button {
    self.passwordTextFiled.text = @"";
    loginType = !loginType;
    if (loginType) {
        //[ZZLimitInputManager limitInputView:self.passwordTextFiled maxLength:4];
        self.passwordTextFiled.placeholder = @"请输入验证码";
        self.passwordTextFiled.secureTextEntry = NO;
        [self.switchLogin setTitle:@"用户密码登录" forState:UIControlStateNormal];
        self.passwordTextFiled.rightView = self.secondButton;
        self.passwordTextFiled.rightViewMode = UITextFieldViewModeAlways;
        self.passwordButton.hidden = YES;
        self.passwordTextFiled.frame = CGRectMake(0, 60, Login_Width-30, 50);
    } else {
        //[ZZLimitInputManager limitInputView:self.passwordTextFiled maxLength:18];
        self.passwordTextFiled.placeholder = @"请输入登录密码";
        passwordHidden = NO;
        [self.passwordButton setImage:[UIImage imageNamed:@"icon_eye_hide"] forState:UIControlStateNormal];
        self.passwordTextFiled.secureTextEntry = YES;
        [self.switchLogin setTitle:@"短信验证码登录" forState:UIControlStateNormal];
        self.passwordTextFiled.rightView = nil;
        self.passwordButton.hidden = NO;
        self.passwordTextFiled.frame = CGRectMake(0, 60, Login_Width-30-30, 50);
    }
}

- (void)sendCode:(UIButton *)button {
    if (self.phoneTextFiled.text.length == 0 ) {
        //[AlertUtil alertWarning:@"账户名不能为空" toView:WINDOWS];
        return;
    }
    if (self.phoneTextFiled.text.length != 11 ) {
        //[AlertUtil alertWarning:@"账户名不正确" toView:WINDOWS];
        return;
    }
    if (self.sendCode) {
        self.sendCode(self.secondButton,self.phoneTextFiled.text);
    }
    
}

- (void)createLoginButton {
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(0, 180, Login_Width-30, 50);
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.loginButton.backgroundColor = Login_RGB(255, 255, 255);
    //[ProjectUtil cutRoundCornerView:self.loginButton cornerRadius:8];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:Login_RGB(56, 75, 159) forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginButton];
}  

- (void)loginClick:(UIButton *)button {
    if (self.phoneTextFiled.text.length == 0) {
        //[AlertUtil alertWarning:@"账户名不能为空" toView:WINDOWS];
        return;
    }
    if (self.passwordTextFiled.text.length == 0) {
        //[AlertUtil alertWarning:loginType?@"验证码不能为空":@"密码不能为空" toView:WINDOWS];
        return;
    }
    if (loginType) {
        if (self.passwordTextFiled.text.length != 4) {
            //[AlertUtil alertWarning:@"验证码不正确" toView:WINDOWS];
            return;
        }
    } else {
    }
    if (self.phoneTextFiled.text.length != 11 ) {
        //[AlertUtil alertWarning:@"账户名不正确" toView:WINDOWS];
        return;
    }
    if (self.loginClick) {
        self.loginClick(self.phoneTextFiled.text,self.passwordTextFiled.text,loginType);
    }
    
}

@end
