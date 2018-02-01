//
//  DeleteCell.m
//  hsbank
//
//  Created by 刘子玉 on 16/6/16.
//  Copyright © 2016年 hsbank. All rights reserved.
//

#import "DeleteCell.h"

@implementation DeleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initUI{
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 1)];
    line.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    [self.contentView addSubview:line];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50,0, [UIScreen mainScreen].bounds.size.width-100, 50);
    [btn setImage:[UIImage imageNamed:@"icon_trash"] forState:UIControlStateNormal];
    [btn setTitle:@"清除历史记录" forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
}
@end
