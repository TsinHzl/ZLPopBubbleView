//
//  ZLPopoverView.m
//  YunDuoYouBao
//
//  Created by Harley He on 18/11/2017.
//  Copyright © 2017 Harley He. All rights reserved.
//

#import "ZLPopBubbleView.h"
#import "ZLPopBubbleController.h"

#define WeakSelf  __weak typeof(self) weakSelf = self

static UIWindow *window_ = nil;
static ZLPopBubbleView *_instance = nil;

@interface ZLPopBubbleView()<NSCopying>

/* popSelectBlock */
@property (copy, nonatomic) void(^confirmClickedModel)(id model);

@end

@implementation ZLPopBubbleView

#pragma mark - 单例
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ZLPopoverView alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark - 各方法

- (void)show {
    window_ = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window_.windowLevel = UIWindowLevelNormal;
    window_.backgroundColor = [UIColor clearColor];
    window_.hidden = NO;
    
    UIButton *coverBtn = [[UIButton alloc] initWithFrame:window_.bounds];
    coverBtn.backgroundColor = [UIColor clearColor];
    [coverBtn addTarget:self action:@selector(tapWindow:) forControlEvents:UIControlEventTouchUpInside];
    [window_ addSubview:coverBtn];
}
- (void)tapWindow:(UIButton *)btn {
    [self hide];
}
- (void)hide {
    window_.rootViewController = nil;
    window_.hidden = YES;
    window_ = nil;
    
}

#pragma mark - 显示popBubbleView
- (void)showPopBubbleViewWithView:(UIView *)view showingView:(UIView *)showingView showingViewH:(CGFloat)showingViewH {
    [self show];
    
    WeakSelf;
    ZLPopBubbleController *popBubbleVc = [ZLPopBubbleController popBubbleWithView:view showingView:showingView showingViewH:showingViewH];
    window_.rootViewController = popBubbleVc;
    popBubbleVc.viewClicked = ^{
        [weakSelf hide];
    };
}

- (void)showPopBubbleViewWithView:(UIView *)view showingView:(UIView *)showingView {
    [self showPopBubbleViewWithView:view showingView:showingView showingViewH:0];
}

@end
