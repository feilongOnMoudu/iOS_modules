//
//  AutorotationVC.m
//  MainProject
//
//  Created by 宋飞龙 on 2018/1/29.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "AutorotationVC.h"
#import "AppDelegate.h"

@interface AutorotationVC ()

@end

@implementation AutorotationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    UILabel * laebl=  [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    laebl.backgroundColor  = [UIColor blueColor];
    [self.view addSubview:laebl];
    // Do any additional setup after loading the view.
}

-(BOOL)shouldAutorotate {
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.allowRotation = 0;
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.allowRotation = 1;
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
}

//支持的方向
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
         return UIInterfaceOrientationMaskLandscapeRight;
     }

 //一开始的方向  很重要
 -(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
         return UIInterfaceOrientationLandscapeRight;
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
