//
//  UITableView+BatchUpdates.m
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

#import "UITableView+BatchUpdates.h"

@implementation UITableView (BatchUpdates)

/**
 仿UICollectionView的[UICollectionView performBatchUpdates:completion]方法，对tableView进行批量更新
 
 @param updates 批量更新（插入或删除）
 @param completion 完成回调
 */
- (void)performBatchUpdatesBlock:(void (^)(void))updates completion:(void (^)(BOOL finished))completion
{
    if (@available(iOS 11.0, *)) {
        [self performBatchUpdates:updates completion:completion];
    }
    else {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            if (completion) completion(YES);
        }];
        [self beginUpdates];
        if (updates) updates();
        [self endUpdates];
        [CATransaction commit];
    }
}

/**
 刷新可见的cells
 
 @param animation 刷新动画
 */
- (void)reloadVisibleRowsWithRowAnimation:(UITableViewRowAnimation)animation
{
    NSArray<NSIndexPath *> *visibleIndexPaths = [self indexPathsForVisibleRows];
    [UIView setAnimationsEnabled:NO];
    [self beginUpdates];
    if (visibleIndexPaths.count > 0) {
        [self reloadRowsAtIndexPaths:visibleIndexPaths withRowAnimation:animation];
    } else {
        [self reloadData];
    }
    [self endUpdates];
    [UIView setAnimationsEnabled:YES];
}


@end
