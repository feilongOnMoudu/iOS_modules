//
//  HSTextField.m
//  hschain
//
//  Created by 宋飞龙 on 2017/7/4.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import "HSTextField.h"

@implementation HSTextField

-(CGRect)borderRectForBounds:(CGRect)bounds {
    bounds.size.height = 50;
    return bounds;
}

-(UIFont *)font {
    self.tintColor = [UIColor whiteColor];
    return [UIFont systemFontOfSize:15];
}

@end
