//
//  DemoVC.h
//  MainProject
//
//  Created by 宋飞龙 on 2018/1/15.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "BaseProjectVC.h"

typedef void(^back)(void);

@interface DemoVC : BaseProjectVC

@property (nonatomic,strong)back block;

- (void)gogogogo:(back)block;

@end
