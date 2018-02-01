//
//  LoginVC.m
//  hschain
//
//  Created by 宋飞龙 on 2017/6/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import <LoginFramework/LoginVC.h>
//#import "LoginVC.h"
#define Login_Width ([UIScreen mainScreen].bounds.size.width)
#define Login_Height ([UIScreen mainScreen].bounds.size.height)

#define Login_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define Login_RGB(r,g,b) Login_RGBA(r,g,b,1.0f)

@interface LoginVC ()<UIScrollViewDelegate,UIGestureRecognizerDelegate> {
    NSString * phoneNum;
}

@end

@implementation LoginVC

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.LoginViewWidth.constant = Login_Width-30;
    self.scrollView.directionalLockEnabled = YES;
    [self addGestureRecognizer];
    [self createTopView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)createTopView {
    self.segmentedControl.sectionTitles = @[@" 登录 ", @" 注册 "];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    //[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : Login_RGB(189, 201, 255),NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
    self.segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentedControl.selectionIndicatorHeight = 2;
    self.segmentedControl.selectionStyle = SegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = SegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.verticalDividerEnabled = NO;
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [self.view endEditing:YES];
        if (index ==0) {
            [self.bottomButton setTitle:@"没有账户？手机快速注册" forState:UIControlStateNormal];
        } else {
            [self.bottomButton setTitle:@"已有账户？立即登录" forState:UIControlStateNormal];
        }
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(Login_Width * index, 0, Login_Width, Login_Height-200) animated:YES];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = Login_Width;
    NSInteger page = self.scrollView.contentOffset.x / pageWidth;
    if (page == 0) {
        [self.bottomButton setTitle:@"没有账户？手机快速注册" forState:UIControlStateNormal];
    } else {
        [self.bottomButton setTitle:@"已有账户？立即登录" forState:UIControlStateNormal];
    }
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    [self.loginView removeList];
}

- (void)layerColor {
    CAGradientLayer *layer = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    layer.colors=@[(__bridge id)Login_RGB(56, 75, 159).CGColor,(__bridge id)Login_RGB(79, 112, 255).CGColor];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.zPosition = -1;
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.loginView removeList];
}

//解决scrollview点击没反应 --》 scrollView本身继承了touch的响应事件，要从新自定义scrollView的响应事件
- (void)addGestureRecognizer {
    UITapGestureRecognizer * sigleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    sigleTap.delegate = self;
    sigleTap.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:sigleTap];
}

#pragma mark ============= scrollView添加手势与tableView冲突解决  =============
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    // 点击了tableViewCell，view的类名为UITableViewCellContentView，则不接收Touch点击事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    [self.loginView removeList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == Login_Width) {
        [self.loginView endEditing:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segue_loginVC_to_forgetVC"]) {
        [segue.destinationViewController setValue:phoneNum forKey:@"phoneNum"];
    }
}

- (IBAction)bottomClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"没有账户？手机快速注册"]) {
        [self.segmentedControl setSelectedSegmentIndex:1 animated:YES];
        [self.scrollView scrollRectToVisible:CGRectMake(Login_Width, 0, Login_Width, Login_Height-200) animated:YES];
        [self.bottomButton setTitle:@"已有账户？立即登录" forState:UIControlStateNormal];
    } else if ([sender.titleLabel.text isEqualToString:@"已有账户？立即登录"]) {
        [self.segmentedControl setSelectedSegmentIndex:0 animated:YES];
        [self.scrollView scrollRectToVisible:CGRectMake(0 , 0, Login_Width, Login_Height-200) animated:YES];
        [self.bottomButton setTitle:@"没有账户？手机快速注册" forState:UIControlStateNormal];
    }
}
@end
