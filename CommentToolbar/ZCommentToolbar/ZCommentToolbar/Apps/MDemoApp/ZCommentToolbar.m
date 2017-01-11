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

#define kPlaceholderColor [UIColor lightGrayColor]

@interface ZCommentToolbar()<UITextViewDelegate>

@property (nonatomic, strong) UIView *panelView;
@property (nonatomic, strong) UIView *maskView;

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
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSDictionary *attributes;

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

- (UIView *)panelView {
    if (!_panelView) {
        _panelView = [[UIView alloc] init];
        _panelView.backgroundColor = [UIColor whiteColor];
        _panelView.tag = 1001;
    }
    return _panelView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, -KScreenHeight, KScreenWidth, 2 * KScreenHeight)];
        _maskView.backgroundColor = [UIColor clearColor];
        _maskView.tag = 1000;
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentToolbarShowBtnClicked:)]];
    }
    return _maskView;
}

- (UITextView *)commentTextView {
    if (!_commentTextView) {
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.commentRightView.frame.size];
        
        NSLayoutManager* layoutManager = [NSLayoutManager new];
        [layoutManager addTextContainer:textContainer];
        
        NSTextStorage* textStorage = [[NSTextStorage alloc] init];
        [textStorage addLayoutManager:layoutManager];
        
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
        _commentRightView.tag = 1002;
        _commentRightView.layer.borderWidth = 1.0f;
        _commentRightView.layer.borderColor = [UIColor colorWithRed:202/255.0 green:203/255.0 blue:204/255.0 alpha:1].CGColor;
    }
    return _commentRightView;
}

- (UIView *)commentLeftView {
    if (!_commentLeftView) {
        _commentLeftView = [[UIView alloc] initWithFrame:CGRectZero];
        _commentLeftView.backgroundColor = [UIColor clearColor];
        _commentLeftView.tag = 1003;
    }
    return _commentLeftView;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _topLineView.backgroundColor = [UIColor colorWithRed:202/255.0 green:203/255.0 blue:204/255.0 alpha:1];
        _topLineView.tag = 1004;
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
    [commentItemView addSubview:[self toolBarItem:@"\U0000e621" tag:1007 action:@selector(commentToolbarCommentBtnClicked:)]];
    return commentItemView;
}

- (void)setupCommentToolbarView {
    //commentToolbarView
    self.backgroundColor = [UIColor clearColor];
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = NO;
    
    [self addSubview:self.panelView];
    [self.panelView addSubview:self.topLineView];
    
    //left view
    self.commentToolbarBackBtn = [self toolBarItem:@"\U0000e61f" tag:1005 action:@selector(commentToolbarBackBtnClicked:)];
    self.commentToolbarShareBtn = [self toolBarItem:@"\U0000e620" tag:1006 action:@selector(commentToolbarShareBtnClicked:)];
    self.commentToolbarCommentBtn = [self setupCommentItemView];
    self.commentToolbarShowBtn = [self toolBarItem:@"\U0000e617" tag:1008 action:@selector(commentToolbarShowBtnClicked:)];
    [self.commentLeftView addSubview:self.commentToolbarBackBtn];
    [self.commentLeftView addSubview:self.commentToolbarShareBtn];
    [self.commentLeftView addSubview:self.commentToolbarCommentBtn];
    [self.panelView addSubview:self.commentLeftView];
    
    //right View
    [self.commentTextView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth) | UIViewAutoresizingFlexibleBottomMargin];
    [self.commentTextView setShowsHorizontalScrollIndicator:NO];
    [self.commentTextView setFont:[UIFont systemFontOfSize:14.0f]];
    [self.commentTextView setTextColor:kPlaceholderColor];
    [self.commentRightView addSubview:self.commentTextView];
    [self.commentRightView addSubview:self.commentSendButton];
    [self.panelView addSubview:self.commentRightView];
    self.commentPlaceholder = @"添加评论";
    self.textColor = [UIColor blackColor];
    
    //设置TextView的字体格式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 字体的行间距
    self.attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                                 NSParagraphStyleAttributeName:paragraphStyle};

    //添加键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentToolBarKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentToolBarKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - setup frames

- (void)setupFrames {
    self.panelView.frame = CGRectMake(0, 0, KScreenWidth, kViewHeight);
    
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

#pragma mark - adjust subview frames

- (void)changeSubviewsFrames {
    CGFloat textViewHeight = [self heightForTextViewWithText:self.commentTextView.text];
    textViewHeight = MAX(textViewHeight, kTextViewHeight);
    CGFloat panelViewHeight = textViewHeight + self.rightViewEdgInsets.top + self.rightViewEdgInsets.bottom;
    self.panelView.frame = CGRectMake(0, self.frame.size.height - panelViewHeight, kScreenWidth, panelViewHeight);
    
    //layout left view frame
    CGRect newLeftViewFrame = self.commentLeftView.frame;
    newLeftViewFrame.origin.y = self.panelView.frame.size.height - kViewHeight;
    self.commentLeftView.frame = newLeftViewFrame;
    
    //layout right view frame
    CGRect newRightViewFrame = self.commentRightView.frame;
    newRightViewFrame.size.height = self.panelView.frame.size.height - self.rightViewEdgInsets.top - self.rightViewEdgInsets.bottom;
    //UITextView frame
    CGRect commentTextViewFrame = CGRectMake(0, 0, newRightViewFrame.size.width, newRightViewFrame.size.height);
    self.commentTextView.frame = commentTextViewFrame;
    self.commentRightView.frame = newRightViewFrame;
    
    CGRect commentSendBtnFrame = CGRectMake(CGRectGetWidth(newRightViewFrame) - kSendBtnWidth, CGRectGetMaxY(commentTextViewFrame) - kSendBtnHeight, kSendBtnWidth, kSendBtnHeight);
    self.commentSendButton.frame = commentSendBtnFrame;
}

#pragma mark - get height for UITextView

- (CGFloat)heightForTextViewWithText:(NSString *)text {
    CGFloat fixedWidth = self.commentTextView.frame.size.width - self.commentTextView.textContainerInset.right - 6;
    CGSize newSize = [text boundingRectWithSize:CGSizeMake(fixedWidth, MAXFLOAT)
                                                            options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                         attributes:self.attributes
                                                            context:nil].size;
    NSLog(@"%.3f",newSize.height);
    return MIN(newSize.height, 112);
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.commentPlaceholder]) {
        textView.text = @"";
        textView.textColor = self.textColor;
        [self.commentSendButton setEnabled:NO];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    [UIView animateWithDuration:0.15 animations:^{
        [self changeSubviewsFrames];
    }];
    NSString *content = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([content isEqualToString:self.commentPlaceholder] ||
        content.length == 0) {
        [self.commentSendButton setEnabled:NO];
    } else {
        [self.commentSendButton setEnabled:YES];
        self.commentTextView.textColor = self.textColor;
    }
    // 判断是否有候选字符，如果不为nil，代表有候选字符
    if(textView.markedTextRange == nil){
        NSRange range = textView.selectedRange;
        textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:self.attributes];
        textView.selectedRange = range;
    }
    NSLog(@"textView.contentOffset = (%.f,%.f)",textView.contentOffset.x,textView.contentOffset.y);
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
    
    CGRect viewFrame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - self.keyboardHeight - 64);
    
    CGFloat textViewHeight = [self heightForTextViewWithText:self.commentTextView.text];
    textViewHeight = MAX(textViewHeight, kTextViewHeight);
    CGRect panelViewFrame = self.frame;
    panelViewFrame.size.height = textViewHeight + self.rightViewEdgInsets.top + self.rightViewEdgInsets.bottom;
    panelViewFrame.origin.y = viewFrame.size.height - panelViewFrame.size.height;
    
    CGRect leftViewFrame = self.commentLeftView.frame;
    leftViewFrame.origin.y = panelViewFrame.size.height - kViewHeight;
    leftViewFrame.size.width = kLeftViewWidth;
    
    CGRect rightViewFrame = self.commentRightView.frame;
    rightViewFrame.origin.x = kLeftViewWidth;
    rightViewFrame.size.width = kScreenWidth - kRightGap - kLeftViewWidth;
    rightViewFrame.size.height = panelViewFrame.size.height - self.rightViewEdgInsets.top - self.rightViewEdgInsets.bottom;

    CGRect commentTextViewFrame = CGRectMake(0, 0, rightViewFrame.size.width, rightViewFrame.size.height);
    
    self.commentTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 0, kSendBtnWidth);
    
    [self insertSubview:self.maskView belowSubview:self.panelView];
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:self.keyboardAnimationDuration
                          delay:0
                        options:(self.keyboardAnimationCurve << 16)
                     animations:^{
                         weakSelf.frame = viewFrame;
                         weakSelf.panelView.frame = panelViewFrame;
                         weakSelf.commentLeftView.frame = leftViewFrame;
                         weakSelf.commentRightView.frame = rightViewFrame;
                         weakSelf.commentTextView.frame = commentTextViewFrame;
                         weakSelf.commentToolbarBackBtn.center = CGPointMake(-118, (kViewHeight / 2.0));
                         weakSelf.commentToolbarShareBtn.center = CGPointMake(-74, (kViewHeight / 2.0));
                         weakSelf.commentToolbarCommentBtn.center = CGPointMake(-30, (kViewHeight / 2.0));
                         weakSelf.commentToolbarShowBtn.center = CGPointMake((kLeftViewWidth / 2.0), (kViewHeight / 2.0));
                         [weakSelf.commentLeftView addSubview:weakSelf.commentToolbarShowBtn];
                         CGRect commentSendBtnFrame = CGRectMake(CGRectGetWidth(rightViewFrame) - kSendBtnWidth, CGRectGetMaxY(commentTextViewFrame) - kSendBtnHeight, kSendBtnWidth, kSendBtnHeight);
                         weakSelf.commentSendButton.frame = commentSendBtnFrame;
                         weakSelf.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
                         weakSelf.maskView.frame = CGRectMake(0, -KScreenHeight, KScreenWidth, 2 * KScreenHeight - panelViewFrame.size.height - weakSelf.keyboardHeight - 64);
                     } completion:^(BOOL finished) {
                         [weakSelf.commentToolbarBackBtn removeFromSuperview];
                         [weakSelf.commentToolbarShareBtn removeFromSuperview];
                         [weakSelf.commentToolbarCommentBtn removeFromSuperview];
                         weakSelf.commentTextView.selectedRange = NSMakeRange(weakSelf.commentTextView.text.length, 0);
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
    
    self.commentTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 0, 0);
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:self.keyboardAnimationDuration
                          delay:0
                        options:(self.keyboardAnimationCurve << 16)
                     animations:^{
                         weakSelf.frame = viewFrame;
                         [weakSelf setupFrames];
                     } completion:^(BOOL finished) {
                         
                     }];}

#pragma mark - create toolbar item

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
    [self.commentTextView setScrollEnabled:NO];
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = kScreenHeight - kViewHeight;
    viewFrame.size.height = kViewHeight;
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [weakSelf.commentToolbarShowBtn removeFromSuperview];
                         weakSelf.maskView.backgroundColor = [UIColor clearColor];
                     } completion:^(BOOL finished) {
                         [weakSelf.commentTextView setScrollEnabled:YES];
                         [weakSelf.maskView removeFromSuperview];
                     }];
    [self.commentTextView resignFirstResponder];
}

#pragma mark - touch to dismiss keyboard

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    UIView *touchView = [touch view];
    if (touchView.tag == 1000) {
        [self commentToolbarShowBtnClicked:touch];
    }
}

#pragma mark - change style 

- (void)commentToolbarAdjustStyleWithNightModel:(BOOL)nightModel {
    if (nightModel) {
        //夜间模式
        self.panelView.backgroundColor = [UIColor colorWithRed:26/255.0 green:32/255.0 blue:38/255.0 alpha:1];
        self.commentRightView.backgroundColor = [UIColor colorWithRed:26/255.0 green:32/255.0 blue:38/255.0 alpha:1];
        self.commentRightView.layer.borderColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1].CGColor;
        self.textColor = [UIColor whiteColor];
    } else {
        //白天模式
        self.panelView.backgroundColor = [UIColor whiteColor];
        self.commentRightView.backgroundColor = [UIColor whiteColor];
        self.commentRightView.layer.borderColor = [UIColor colorWithRed:202/255.0 green:203/255.0 blue:204/255.0 alpha:1].CGColor;
        self.textColor = [UIColor blackColor];
    }
    
    if (![self.commentTextView.textColor isEqual:kPlaceholderColor]) {
        self.commentTextView.textColor = self.textColor;
    }
}

@end
