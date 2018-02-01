//
//  DropDownListCell.m
//  DropDownList
//
//  Created by 宋飞龙 on 16/6/1.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import "DropDownListCell.h"

@implementation DropDownListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initUI {
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 150, 50)];
    self.numberLabel.font = [UIFont systemFontOfSize:14];
    self.numberLabel.textColor = [UIColor blackColor];
    [self.contentView  addSubview:self.numberLabel];
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    [self.contentView addSubview:line];
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30-40, 10, 30, 30);
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    [self.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.closeBtn];
}

@end
