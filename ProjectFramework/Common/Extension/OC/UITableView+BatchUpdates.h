//
//  UITableView+BatchUpdates.h
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BatchUpdates)

/**
 仿UICollectionView的[UICollectionView performBatchUpdates:completion]方法，对tableView进行批量更新
 
 @param updates 批量更新（插入或删除）
 @param completion 完成回调
 */
- (void)performBatchUpdatesBlock:(void (^)(void))updates completion:(void (^)(BOOL finished))completion;

/**
 刷新可见的cells
 
 @param animation 刷新动画
 */
- (void)reloadVisibleRowsWithRowAnimation:(UITableViewRowAnimation)animation;

@end
