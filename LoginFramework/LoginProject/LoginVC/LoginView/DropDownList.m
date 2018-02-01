//
//  DropDownList.m
//  DropDownList
//
//  Created by 宋飞龙 on 16/5/24.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import "DropDownList.h"
#import "DropDownListCell.h"
#import "DeleteCell.h"
#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height

@interface DropDownList ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray *tableDataSource;


@end

@implementation DropDownList

+ (void)showDropDownListDataSource:(NSMutableArray *)dataSource
                            onView:(UIView *)onView
                    didSelectBlock:(CellSelectBlock)didSelectBlock
                      deleateBlock:(DeleateBlock)deleateBlock {
    [DropDownList dropDownList:dataSource.count].didSelectBlock = didSelectBlock;
    [DropDownList dropDownList:dataSource.count].deleateBlock = deleateBlock;
    [DropDownList dropDownList:dataSource.count].tableDataSource  = dataSource;
    [DropDownList dropDownList:dataSource.count].frame = CGRectMake(0, 50,kWidth-30 , (dataSource.count+1)*50);
    UITableView * tableView =[[UITableView alloc] initWithFrame:[DropDownList dropDownList:dataSource.count].bounds style:UITableViewStylePlain];
    [DropDownList dropDownList:dataSource.count].tableView = tableView;
    [DropDownList dropDownList:dataSource.count].tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [DropDownList dropDownList:dataSource.count].tableView.delegate = [DropDownList dropDownList:dataSource.count];
    [DropDownList dropDownList:dataSource.count].tableView.dataSource = [DropDownList dropDownList:dataSource.count];
    [[DropDownList dropDownList:dataSource.count] addSubview:[DropDownList dropDownList:dataSource.count].tableView];
    [DropDownList dropDownList:dataSource.count].tableView.scrollEnabled = NO;
    [[DropDownList dropDownList:dataSource.count].tableView reloadData];
    [onView addSubview:[DropDownList dropDownList:dataSource.count]];
}

+ (void)removeDropDownList{
    [[DropDownList dropDownList:0].tableView removeFromSuperview];
    [[DropDownList dropDownList:0] removeFromSuperview];
}

+ (DropDownList *)dropDownList:(NSUInteger)dataSourcesCount {
    static DropDownList * dropDownList;
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        dropDownList = [[DropDownList alloc] initWithFrame:CGRectMake(0, 50,kWidth-30 , (dataSourcesCount+1)*50)];
    });
    return dropDownList;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count+1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row<self.tableDataSource.count) {
        static NSString * cellId = @"cell";
        DropDownListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DropDownListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        if (self.tableDataSource.count > indexPath.row) {
            cell.numberLabel.text = self.tableDataSource[indexPath.row];
            cell.closeBtn.tag = indexPath.row;
            [cell.closeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else{
        static NSString * cellId = @"deleteCell";
        DeleteCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
          cell = [[DeleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    }
}

- (void)btnClick:(UIButton *)button {
    if (self.deleateBlock) {
        [self.tableDataSource removeObjectAtIndex:button.tag];
        self.frame = CGRectMake(0, 50,kWidth-30 , (self.tableDataSource.count+1)*50);
        self.tableView.frame = self.bounds;
        [self.tableView reloadData];
        self.deleateBlock(self.tableDataSource);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<self.tableDataSource.count) {
        if (self.didSelectBlock) {
            self.didSelectBlock(self.tableDataSource[indexPath.row]);
        }
    }else{
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:@"确认取消全部登录历史？" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.tableDataSource removeAllObjects];
            if (self.deleateBlock) {
                self.frame = CGRectMake(0, 50,kWidth-30 ,50);
                self.tableView.frame = self.bounds;
                [self.tableView reloadData];
                _deleateBlock(self.tableDataSource);
            }
        }]];
        for (UIView* next = [self superview]; next; next = next.superview) {
            UIResponder* nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                [(UIViewController*)nextResponder presentViewController:alertVC animated:YES completion:nil];
                return;
            }
        }
    }
}

@end
