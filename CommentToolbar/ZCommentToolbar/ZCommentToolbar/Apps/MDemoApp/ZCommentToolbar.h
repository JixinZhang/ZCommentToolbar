//
//  ZCommentToolbar.h
//  MessageToolDemo
//
//  Created by ZhangBob on 28/12/2016.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZCommentToolbarAction) {
    ZCommentToolbarActionBack = 0,  //back action
    ZCommentToolbarActionShare,     //share action
    ZCommentToolbarActionComment,   //comment action
};

@protocol ZCommentToolbarDelegate <NSObject>

/**
 点击左侧三个按钮中的一个

 @param commentToolbarAction back, share, comment
 */
- (void)commentToolbarActionMethod:(ZCommentToolbarAction)commentToolbarAction;

/**
 点击发送按钮

 @param content 发送的内容
 */
- (void)commentToolbarSendMesasgeWithContent:(NSString *)content;

@end

@interface ZCommentToolbar : UIView

@property (nonatomic, strong) UITextView *commentTextView;
/**
 placeholder，通过set方法赋值
 */
@property (nonatomic, copy) NSString *commentPlaceholder;

/**
 ZCommentToolbarDelegate 代理中包含两个方法：
 - (void)commentToolbarActionMethod:(ZCommentToolbarAction)commentToolbarAction;
 - (void)commentToolbarSendMesasgeWithContent:(NSString *)content;
 */
@property (nonatomic, weak) id<ZCommentToolbarDelegate> delegate;

/**
 评论的数量，通过set方法赋值
 */
@property (nonatomic, assign) NSUInteger commentCount;

/**
 更换commentToolbar的颜色

 @param nightModel 是否为夜间模式
 */
- (void)commentToolbarAdjustStyleWithNightModel:(BOOL)nightModel;

@end
