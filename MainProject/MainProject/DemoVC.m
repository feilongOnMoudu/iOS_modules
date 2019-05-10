//
//  DemoVC.m
//  MainProject
//
//  Created by 宋飞龙 on 2018/1/15.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "DemoVC.h"
#import "AutorotationVC.h"
#import "BaseNavigationController.h"
#import <LoginFramework/LoginFramework.h>

@interface DemoVC ()

@end

@implementation DemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.autorotation = YES;
    UILabel * laebl=  [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 200,200)];
    laebl.backgroundColor  = [UIColor blueColor];
    [self.view addSubview:laebl];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 500, 100, 50);
    [button setTitle:@"gotologin" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

-(BOOL)shouldAutorotate{
    
    return YES;
    
}

- (void)gotoLogin {
    if (self.block) {
        self.block();
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LoginFramework" ofType:@"framework"];
    NSLog(@"path = %@", path);
    
    NSBundle *myBundle = [NSBundle bundleWithPath:path];
    NSLog(@"myBunlde = %@", myBundle);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:myBundle];
    
    LoginVC * cview = (LoginVC *)[storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    BaseNavigationController * nav = [[BaseNavigationController alloc] initWithRootViewController:cview];
    
    cview.view.backgroundColor = [UIColor yellowColor];
    cview.navigationItem.title = @"213213";
    cview.loginView.loginClick = ^(NSString *account, NSString *password, BOOL loginType) {
        NSLog(@"account = %@ --- password = %@",account,password);
        [cview dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Began");
    
    
    
//    AutorotationVC * vc = [[AutorotationVC alloc] init];
//    [self presentViewController:vc animated:NO completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gogogogo:(back)block {
    self.block = block;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
