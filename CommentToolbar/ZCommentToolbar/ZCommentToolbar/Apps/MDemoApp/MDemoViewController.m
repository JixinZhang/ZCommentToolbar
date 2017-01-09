//
//   _      ________________ 
//  | | /| / / ___/ ___/ __ \
//  | |/ |/ (__  ) /__/ / / /
//  |__/|__/____/\___/_/ /_/ 
//
//  Created by Micker on 2016/12/9.
//  Copyright © 2016年 WSCN. All rights reserved.
//

#import "MDemoViewController.h"
#import "ZCommentToolbar.h"

@interface MDemoViewController ()<ZCommentToolbarDelegate>

@property (nonatomic, strong) ZCommentToolbar *commentToolbar;

@end

@implementation MDemoViewController

#pragma mark -- Override

- (void)viewDidLoad {
    [super viewDidLoad];
    [self m_configViews];
    [self m_configEvents];
    [self m_configDatas];
}

#pragma mark -- Internal

- (void) m_configViews {
    //配置视图
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.commentToolbar];
    self.commentToolbar.commentCount = 20;
}

- (void) m_configEvents {
    //配置事件
}

- (void) m_configDatas {
    //配置数据
    self.title = @"Demo App";
}

#pragma mark -- Action



#pragma mark -- Getter

- (ZCommentToolbar *)commentToolbar {
    if (!_commentToolbar) {
        _commentToolbar = [[ZCommentToolbar alloc] init];
        _commentToolbar.delegate = self;
        _commentToolbar.commentPlaceholder = @"wirte something";
    }
    return _commentToolbar;
}

#pragma mark -- Setter

#pragma mark - ZCommentToolbarDelegate

- (void)commentToolbarSendMesasgeWithContent:(NSString *)content {
    [self showMessageWith:content];
}

- (void)commentToolbarActionMethod:(ZCommentToolbarAction)commentToolbarAction {
    switch (commentToolbarAction) {
        case ZCommentToolbarActionBack:
            [self.commentToolbar setCommentCount:21];
            [self showMessageWith:@"返回"];
            break;
        case ZCommentToolbarActionShare:
            [self showMessageWith:@"分享"];
            break;
        case ZCommentToolbarActionComment:
            [self showMessageWith:@"评论"];
            break;
        default:
            break;
    }
}

- (void)showMessageWith:(NSString *)string {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:string preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
