//
//  BaseEmptyView.h
//  GoldBaseFramework
//
//  Created by Micker on 2016/10/24.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 默认显示空视图，图片在上，标签在下
 */
@interface BaseEmptyView : UIControl

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel   *label;

@end


#pragma mark UIView ( emptyView )

@interface UIView ( emptyView )

@property (nonatomic, strong) BaseEmptyView   *baseEmptyView;


/**
 显示带有提示标签的空视图，注意，若未主动设置baseEmptyView，则使用默认空视图【220 * 200】，且在当前视图的正中间

 @param tips 提示语句
 */
- (void) showEmptyViewWith:(NSString *) tips;


/**
 隐藏当前空视图
 */
- (void) hideEmptyView;

@end
