//
//  ZCommentToolbar.m
//  MessageToolDemo
//
//  Created by ZhangBob on 28/12/2016.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "ZCommentToolbar.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height - 64

#define kRightGap 15.0f
#define kLeftViewWidth 60.0f
#define kViewHeight 48.0f
#define kTextViewHeight 34.0f
#define kSendBtnWidth 34.0f
#define kSendBtnHeight 34.0f

@interface ZCommentToolbar()<UITextViewDelegate>

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIButton *commentSendButton;
@property (nonatomic, strong) UIView *commentRightView;

@property (nonatomic, strong) UIView *commentToolbarBackBtn;
@property (nonatomic, strong) UIView *commentToolbarShareBtn;
@property (nonatomic, strong) UIView *commentToolbarCommentBtn;
@property (nonatomic, strong) UIView *commentToolbarShowBtn;
@property (nonatomic, strong) UIView *commentLeftView;

@property (nonatomic, assign) UIEdgeInsets rightViewEdgInsets;

@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) CGFloat keyboardAnimationDuration;
@property (nonatomic, assign) NSInteger keyboardAnimationCurve;

@end

@implementation ZCommentToolbar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kScreenHeight - kViewHeight + 64, kScreenWidth, kViewHeight);
        [self setupCommentToolbarView];
        [self setupFrames];
    }
    return self;
}

#pragma mark - Getter

- (UITextView *)commentTextView {
    if (!_commentTextView) {
        NSTextStorage* textStorage = [[NSTextStorage alloc] init];
        NSLayoutManager* layoutManager = [NSLayoutManager new];
        [textStorage addLayoutManager:layoutManager];
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.bounds.size];
        [layoutManager addTextContainer:textContainer];
        
        _commentTextView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:textContainer];
        _commentTextView.backgroundColor = [UIColor clearColor];
        _commentTextView.delegate = self;
    }
    return _commentTextView;
}

- (UIButton *)commentSendButton {
    if (!_commentSendButton) {
        _commentSendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentSendButton.center = CGPointMake(kScreenWidth, kSendBtnHeight / 2.0);
        _commentSendButton.enabled = NO;
        [_commentSendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_commentSendButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_commentSendButton setTitleColor:[UIColor colorWithRed:0/255.0 green:100/255.0 blue:199/255.0 alpha:1] forState:UIControlStateNormal];
        [_commentSendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_commentSendButton addTarget:self
                               action:@selector(commentSendButtonClicked:)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentSendButton;
}

- (UIView *)commentRightView {
    if (!_commentRightView) {
        _commentRightView = [[UIView alloc] initWithFrame:CGRectZero];
        _commentRightView.backgroundColor = [UIColor whiteColor];
        _commentRightView.layer.borderWidth = 1.0f;
        _commentRightView.layer.borderColor = [UIColor colorWithRed:202/255.0 green:203/255.0 blue:204/255.0 alpha:1].CGColor;
    }
    return _commentRightView;
}

- (UIView *)commentLeftView {
    if (!_commentLeftView) {
        _commentLeftView = [[UIView alloc] initWithFrame:CGRectZero];
        _commentLeftView.backgroundColor = [UIColor clearColor];
    }
    return _commentLeftView;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _topLineView.backgroundColor = [UIColor colorWithRed:202/255.0 green:203/255.0 blue:204/255.0 alpha:1];
    }
    return _topLineView;
}

#pragma mark - Setter

- (void)setCommentPlaceholder:(NSString *)commentPlaceholder {
    _commentPlaceholder = commentPlaceholder;
    [self.commentTextView setText:_commentPlaceholder];
}

- (void)setCommentCount:(NSUInteger)commentCount {
    _commentCount = commentCount;
    UILabel *commentCountLabel = [self.commentToolbarCommentBtn viewWithTag:104];
    if (!commentCountLabel) {
        commentCountLabel = [[UILabel alloc] init];
        commentCountLabel.tag = 104;
        commentCountLabel.textColor = [UIColor whiteColor];
        commentCountLabel.font = [UIFont systemFontOfSize:10.0f];
        commentCountLabel.textAlignment = NSTextAlignmentCenter;
        commentCountLabel.backgroundColor = [UIColor colorWithRed:20/255.0 green:130/255.0 blue:244/255.0 alpha:1];
        commentCountLabel.layer.cornerRadius = 4.0f;
        commentCountLabel.layer.masksToBounds = YES;
        [self.commentToolbarCommentBtn addSubview:commentCountLabel];
    }
    commentCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.commentCount];
    CGSize labelSize = [commentCountLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 12)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:commentCountLabel.font}
                                                            context:nil].size;
    if (labelSize.width > 25) {
        commentCountLabel.frame = CGRectMake(25, 7, 25, 12);
        commentCountLabel.adjustsFontSizeToFitWidth = YES;
    } else if (labelSize.width > 15) {
        commentCountLabel.frame = CGRectMake(25, 7, labelSize.width, 12);
        [commentCountLabel sizeToFit];
    } else {
        commentCountLabel.frame = CGRectMake(25, 7, 15, 12);
    }
}

#pragma mark - setup view


- (UIView *)setupCommentItemView {
    UIView *commentItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    commentItemView.backgroundColor = [UIColor clearColor];
    [commentItemView addSubview:[self toolBarItem:@"\U0000e621" tag:102 action:@selector(commentToolbarCommentBtnClicked:)]];
    return commentItemView;
}

- (void)setupCommentToolbarView {
    //commentToolbarView
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = NO;
    [self addSubview:self.topLineView];
    
    //left view
    self.commentToolbarBackBtn = [self toolBarItem:@"\U0000e61f" tag:100 action:@selector(commentToolbarBackBtnClicked:)];
    self.commentToolbarShareBtn = [self toolBarItem:@"\U0000e620" tag:101 action:@selector(commentToolbarShareBtnClicked:)];
    self.commentToolbarCommentBtn = [self setupCommentItemView];
    self.commentToolbarShowBtn = [self toolBarItem:@"\U0000e60c" tag:103 action:@selector(commentToolbarShowBtnClicked:)];
    [self.commentLeftView addSubview:self.commentToolbarBackBtn];
    [self.commentLeftView addSubview:self.commentToolbarShareBtn];
    [self.commentLeftView addSubview:self.commentToolbarCommentBtn];
    [self addSubview:self.commentLeftView];
    
    //right View
    [self.commentTextView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth) | UIViewAutoresizingFlexibleBottomMargin];
    [self.commentTextView setShowsHorizontalScrollIndicator:NO];
    [self.commentTextView setFont:[UIFont systemFontOfSize:14.0f]];
    [self.commentTextView setTextColor:[UIColor lightGrayColor]];
    [self.commentRightView addSubview:self.commentTextView];
    [self.commentRightView addSubview:self.commentSendButton];
    [self addSubview:self.commentRightView];
    self.commentPlaceholder = @"添加评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentToolBarKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentToolBarKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupFrames {
    //left View frame
    CGRect leftViewFrame = CGRectMake(0, self.frame.size.height - kViewHeight, ((kScreenWidth - kRightGap) / 2.0), kViewHeight);
    self.commentLeftView.frame = leftViewFrame;
    
    CGFloat leftGap = 33;
    CGFloat leftViewBtnWidth = _commentToolbarBackBtn.frame.size.width;
    self.commentToolbarBackBtn.center = CGPointMake(leftViewBtnWidth * 0 + leftGap , (kViewHeight / 2.0));
    self.commentToolbarShareBtn.center = CGPointMake(leftViewBtnWidth * 1 + leftGap, (kViewHeight / 2.0));
    self.commentToolbarCommentBtn.center = CGPointMake(leftViewBtnWidth * 2 + leftGap, (kViewHeight / 2.0));
    self.commentToolbarShowBtn.center = CGPointMake(leftViewBtnWidth * 4 + leftGap, (kViewHeight / 2.0));
    
    self.rightViewEdgInsets = UIEdgeInsetsMake(7, 0, 7, 0);
    //right view frame
    CGRect rightViewFrame = CGRectMake(((kScreenWidth - kRightGap) / 2.0), self.rightViewEdgInsets.top, ((kScreenWidth - kRightGap) / 2.0), self.frame.size.height - self.rightViewEdgInsets.top - self.rightViewEdgInsets.bottom);
    self.commentRightView.frame = rightViewFrame;
    //UITextView frame
    CGRect commentTextViewFrame = CGRectMake(0, 0, rightViewFrame.size.width, rightViewFrame.size.height);
    self.commentTextView.frame = commentTextViewFrame;
}

- (void)changeSubviewsFrames {
    CGFloat textViewHeight = [self heightForTextViewWithText:self.commentTextView.text];
    textViewHeight = MAX(textViewHeight, kTextViewHeight);
    CGFloat viewHeight = textViewHeight + self.rightViewEdgInsets.top + self.rightViewEdgInsets.bottom;
    self.frame = CGRectMake(0, kScreenHeight - self.keyboardHeight - viewHeight, kScreenWidth, viewHeight);
    
    //layout left view frame
    CGRect newLeftViewFrame = self.commentLeftView.frame;
    newLeftViewFrame.origin.y = self.frame.size.height - kViewHeight;
    self.commentLeftView.frame = newLeftViewFrame;
    
    //layout right view frame
    CGRect newRightViewFrame = self.commentRightView.frame;
    newRightViewFrame.size.height = self.frame.size.height - self.rightViewEdgInsets.top - self.rightViewEdgInsets.bottom;
    self.commentRightView.frame = newRightViewFrame;
    //UITextView frame
    CGRect commentTextViewFrame = CGRectMake(0, 0, newRightViewFrame.size.width - kSendBtnWidth, newRightViewFrame.size.height);
    self.commentTextView.frame = commentTextViewFrame;
    
    CGRect commentSendBtnFrame = CGRectMake(CGRectGetWidth(newRightViewFrame) - kSendBtnWidth, CGRectGetMaxY(commentTextViewFrame) - kSendBtnHeight, kSendBtnWidth, kSendBtnHeight);
    self.commentSendButton.frame = commentSendBtnFrame;
}

- (CGFloat)heightForTextViewWithText:(NSString *)text {
    CGFloat fixedWidth = self.commentTextView.contentSize.width;
    CGSize newSize = [self.commentTextView.text boundingRectWithSize:CGSizeMake(fixedWidth, CGFLOAT_MAX)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:self.commentTextView.font}
                                                            context:nil].size;
    return MIN(newSize.height, 120);
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.commentPlaceholder]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        [self.commentSendButton setEnabled:NO];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    [self changeSubviewsFrames];
    NSString *content = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([content isEqualToString:self.commentPlaceholder] ||
        content.length == 0) {
        [self.commentSendButton setEnabled:NO];
    } else {
        [self.commentSendButton setEnabled:YES];
        self.commentTextView.textColor = [UIColor blackColor];
    }
}

#pragma mark - show/hide keyboard

- (void)commentToolBarKeyboardWillShow:(NSNotification *)notification {
    NSDictionary * userInfo=[notification userInfo];
    //获取键盘的高度
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardHeight = [aValue CGRectValue].size.height;
    //获取键盘弹出的时间
    self.keyboardAnimationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //获取键盘弹出的时间曲线
    self.keyboardAnimationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGFloat textViewHeight = [self heightForTextViewWithText:self.commentTextView.text];
    textViewHeight = MAX(textViewHeight, kTextViewHeight);
    CGRect viewFrame = self.frame;
    viewFrame.size.height = textViewHeight + self.rightViewEdgInsets.top + self.rightViewEdgInsets.bottom;
    viewFrame.origin.y = kScreenHeight - self.keyboardHeight - viewFrame.size.height;
    
    CGRect leftViewFrame = self.commentLeftView.frame;
    leftViewFrame.origin.y = viewFrame.size.height - kViewHeight;
    leftViewFrame.size.width = kLeftViewWidth;
    
    CGRect rightViewFrame = self.commentRightView.frame;
    rightViewFrame.origin.x = kLeftViewWidth;
    rightViewFrame.size.width = kScreenWidth - kRightGap - kLeftViewWidth;
    rightViewFrame.size.height = viewFrame.size.height - self.rightViewEdgInsets.top - self.rightViewEdgInsets.bottom;

    CGRect commentTextViewFrame = CGRectMake(0, 0, rightViewFrame.size.width - kSendBtnWidth, rightViewFrame.size.height);
    
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:self.keyboardAnimationDuration
                          delay:0
                        options:(self.keyboardAnimationCurve << 16)
                     animations:^{
                         weakSelf.frame = viewFrame;
                         weakSelf.commentLeftView.frame = leftViewFrame;
                         weakSelf.commentRightView.frame = CGRectMake(rightViewFrame.origin.x - 4, rightViewFrame.origin.y, rightViewFrame.size.width + 4, rightViewFrame.size.height);
                         weakSelf.commentTextView.frame = commentTextViewFrame;
                         weakSelf.commentToolbarBackBtn.center = CGPointMake(-50, (kViewHeight / 2.0));
                         weakSelf.commentToolbarShareBtn.center = CGPointMake(-50, (kViewHeight / 2.0));
                         weakSelf.commentToolbarCommentBtn.center = CGPointMake(-50, (kViewHeight / 2.0));
                         weakSelf.commentToolbarShowBtn.center = CGPointMake((kLeftViewWidth / 2.0) - 4, (kViewHeight / 2.0));
                         [weakSelf.commentLeftView addSubview:weakSelf.commentToolbarShowBtn];
                         CGRect commentSendBtnFrame = CGRectMake(CGRectGetWidth(rightViewFrame) - kSendBtnWidth, CGRectGetMaxY(commentTextViewFrame) - kSendBtnHeight, kSendBtnWidth, kSendBtnHeight);
                         weakSelf.commentSendButton.frame = commentSendBtnFrame;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.15
                                          animations:^{
                                              weakSelf.commentRightView.frame = rightViewFrame;
                                              weakSelf.commentToolbarShowBtn.center = CGPointMake((kLeftViewWidth / 2.0), (kViewHeight / 2.0));
                                          } completion:^(BOOL finished) {
                                              [weakSelf.commentToolbarBackBtn removeFromSuperview];
                                              [weakSelf.commentToolbarShareBtn removeFromSuperview];
                                              [weakSelf.commentToolbarCommentBtn removeFromSuperview];
                                              weakSelf.commentTextView.selectedRange = NSMakeRange(weakSelf.commentTextView.text.length, 0);
                                          }];
                     }];
}

- (void)commentToolBarKeyboardWillHide:(NSNotification *)notification {
    NSDictionary * userInfo=[notification userInfo];
    //获取键盘的高度
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardHeight = [aValue CGRectValue].size.height;
    //获取键盘弹出的时间
    self.keyboardAnimationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //获取键盘弹出的时间曲线
    self.keyboardAnimationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = kScreenHeight - kViewHeight;
    viewFrame.size.height = kViewHeight;
    
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:self.keyboardAnimationDuration
                          delay:0
                        options:(self.keyboardAnimationCurve << 16)
                     animations:^{
                         weakSelf.frame = viewFrame;
                         //left View frame
                         CGRect leftViewFrame = CGRectMake(0, self.frame.size.height - kViewHeight, ((kScreenWidth - kRightGap) / 2.0), kViewHeight);
                         self.commentLeftView.frame = leftViewFrame;
                         
                         CGFloat leftGap = 33 + 4;
                         CGFloat leftViewBtnWidth = _commentToolbarBackBtn.frame.size.width;
                         self.commentToolbarBackBtn.center = CGPointMake(leftViewBtnWidth * 0 + leftGap , (kViewHeight / 2.0));
                         self.commentToolbarShareBtn.center = CGPointMake(leftViewBtnWidth * 1 + leftGap, (kViewHeight / 2.0));
                         self.commentToolbarCommentBtn.center = CGPointMake(leftViewBtnWidth * 2 + leftGap, (kViewHeight / 2.0));
                         self.commentToolbarShowBtn.center = CGPointMake(leftViewBtnWidth * 4 + leftGap, (kViewHeight / 2.0));
                         
                         self.rightViewEdgInsets = UIEdgeInsetsMake(7, 0, 7, 0);
                         //right view frame
                         CGRect rightViewFrame = CGRectMake(((kScreenWidth - kRightGap) / 2.0) + 4, self.rightViewEdgInsets.top, ((kScreenWidth - kRightGap) / 2.0) - 4, self.frame.size.height - self.rightViewEdgInsets.top - self.rightViewEdgInsets.bottom);
                         self.commentRightView.frame = rightViewFrame;
                         //UITextView frame
                         CGRect commentTextViewFrame = CGRectMake(0, 0, rightViewFrame.size.width, rightViewFrame.size.height);
                         self.commentTextView.frame = commentTextViewFrame;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.15
                                          animations:^{
                                              [weakSelf setupFrames];
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

- (UIView *)toolBarItem:(NSString *) title tag:(NSUInteger) tag action:(SEL) action {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 44, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    label.text = title;
    label.tag = 100;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"iconfont" size:16];
    [view addSubview:label];
    
    view.tag = tag;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:action]];
    return view;
}

#pragma mark - action methods 

- (IBAction)commentSendButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentToolbarSendMesasgeWithContent:)]) {
        [self.delegate commentToolbarSendMesasgeWithContent:self.commentTextView.text];
    }
}

- (IBAction)commentToolbarBackBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentToolbarActionMethod:)]) {
        [self.delegate commentToolbarActionMethod:ZCommentToolbarActionBack];
    }
}

- (IBAction)commentToolbarShareBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentToolbarActionMethod:)]) {
        [self.delegate commentToolbarActionMethod:ZCommentToolbarActionShare];
    }
}

- (IBAction)commentToolbarCommentBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentToolbarActionMethod:)]) {
        [self.delegate commentToolbarActionMethod:ZCommentToolbarActionComment];
    }
}

- (IBAction)commentToolbarShowBtnClicked:(id)sender {
    [self.commentLeftView addSubview:self.commentToolbarBackBtn];
    [self.commentLeftView addSubview:self.commentToolbarShareBtn];
    [self.commentLeftView addSubview:self.commentToolbarCommentBtn];

    CGRect viewFrame = self.frame;
    viewFrame.origin.y = kScreenHeight - kViewHeight;
    viewFrame.size.height = kViewHeight;
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [weakSelf.commentToolbarShowBtn removeFromSuperview];
                     } completion:^(BOOL finished) {
                         
                     }];
    [self.commentTextView resignFirstResponder];
}

@end
