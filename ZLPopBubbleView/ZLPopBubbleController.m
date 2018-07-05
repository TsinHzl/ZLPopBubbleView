//
//  ZLPopBubbleController.m
//  TYWJBus
//
//  Created by Harley He on 2018/6/20.
//  Copyright © 2018 Harley He. All rights reserved.
//

#import "ZLPopBubbleController.h"
#import "ZLPopBubbleView.h"


#define ZLPopBubbleScreenBounds [UIScreen mainScreen].bounds
#define ZLPopBubbleScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZLPopBubbleScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat ZLPopBubbleEffectViewAlpha = 0.65f;
static CGFloat ZLPopBubbleViewW = 130.f;
static CGFloat ZLPopBubbleViewH = 220.f;
static CGFloat ZLPopBubbleViewMargin = 10.f;
static CGFloat ZLPopBubbleViewAnimTimeinterval = 0.3f;


@interface ZLPopBubbleController ()

/* effectView */
@property (strong, nonatomic) UIVisualEffectView *effectView;
/* popBubbleView */
@property (strong, nonatomic) ZLPopBubbleView *popBubbleView;
/* 显示时候的frame */
@property (assign, nonatomic) CGRect showFrame;
/* 缩小时的frame */
@property (assign, nonatomic) CGRect smallFrame;
/* showingViewH */
@property (assign, nonatomic) CGFloat showingViewH;

/** 私有方法 **/
- (void)p_zl_setupView;
- (void)p_zl_animShowPopBubbleViewCompletion:(void(^)(void))completion;
- (void)p_zl_animHidePopBubbleViewCompletion:(void(^)(void))completion;
- (void)p_zl_clickView;

+ (ZLPopBubbleViewDirection)p_zl_getPopBubbleViewDirectionWithRect:(CGRect)frame showingViewH:(CGFloat)showingViewH;
+ (CGRect)p_zl_getPopBubbleViewFrameWithRect:(CGRect)frame showingViewH:(CGFloat)showingViewH;
+ (CGPoint)p_zl_getPopBubbleViewArrowPointWithRect:(CGRect)frame showingViewH:(CGFloat)showingViewH;

@end

@implementation ZLPopBubbleController

#pragma mark - 懒加载
- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectView.alpha = ZLPopBubbleEffectViewAlpha;
        _effectView.frame = self.view.bounds;
    }
    return _effectView;
}

- (ZLPopBubbleView *)popBubbleView {
    if (!_popBubbleView) {
        _popBubbleView = [[ZLPopBubbleView alloc] initWithFrame:self.showFrame];
    }
    return _popBubbleView;
}
#pragma mark - set up view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_zl_setupView];
}

#pragma mark - 私有方法
- (void)p_zl_setupView {
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.effectView];
    [self.view addSubview:self.popBubbleView];
}

- (void)p_zl_animShowPopBubbleViewCompletion:(void(^)(void))completion {
    WeakSelf;
    self.popBubbleView.alpha = 0;
    self.popBubbleView.contentView.zl_height = 0;
    [UIView animateWithDuration:ZLPopBubbleViewAnimTimeinterval delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.popBubbleView.contentView.zl_height = self.showFrame.size.height - 10.f;
        weakSelf.popBubbleView.alpha = 1.f;
        weakSelf.effectView.alpha = ZLPopBubbleEffectViewAlpha;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)p_zl_animHidePopBubbleViewCompletion:(void(^)(void))completion  {
    WeakSelf;
    [UIView animateWithDuration:ZLPopBubbleViewAnimTimeinterval delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.popBubbleView.contentView.zl_height = 0;
        weakSelf.effectView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf p_zl_clickView];
        if (completion) {
            completion();
        }
    }];
}
+ (CGRect)p_zl_getPopBubbleViewFrameWithRect:(CGRect)frame showingViewH:(CGFloat)showingViewH {
    CGRect newF = CGRectZero;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = ZLPopBubbleViewW;
    CGFloat h = showingViewH > 0 ? showingViewH + ZLPopBubbleViewMargin : ZLPopBubbleViewH;
    
    CGFloat centerX = frame.size.width/2.f + frame.origin.x;
    if ([self p_zl_getPopBubbleViewDirectionWithRect:frame showingViewH:showingViewH] == ZLPopBubbleViewDirectionTop) {
        y = CGRectGetMinY(frame) - h;
        
        if (centerX - ZLPopBubbleViewW/2.f < ZLPopBubbleViewMargin) {
            x = ZLPopBubbleViewMargin;
        }else if (ZLPopBubbleViewW + centerX + ZLPopBubbleViewMargin > ZLPopBubbleScreenWidth) {
            x = ZLPopBubbleScreenWidth - ZLPopBubbleViewW - ZLPopBubbleViewMargin;
        }else {
            x = centerX - ZLPopBubbleViewW/2.f;
        }
    }else if([self p_zl_getPopBubbleViewDirectionWithRect:frame showingViewH:showingViewH] == ZLPopBubbleViewDirectionBottom){
        y = CGRectGetMaxY(frame);
        
        if (centerX - ZLPopBubbleViewW/2.f < ZLPopBubbleViewMargin) {
            x = ZLPopBubbleViewMargin;
        }else if (ZLPopBubbleViewW + centerX + ZLPopBubbleViewMargin > ZLPopBubbleScreenWidth) {
            x = ZLPopBubbleScreenWidth - ZLPopBubbleViewW - ZLPopBubbleViewMargin;
        }else {
            x = centerX - ZLPopBubbleViewW/2.f;
        }
    }
    
    newF = CGRectMake(x, y, w, h);
    
    return newF;
}
+ (ZLPopBubbleViewDirection)p_zl_getPopBubbleViewDirectionWithRect:(CGRect)frame showingViewH:(CGFloat)showingViewH {
    CGFloat height = showingViewH > 0 ? showingViewH + ZLPopBubbleViewMargin : ZLPopBubbleViewH;
    CGFloat topDeltaH = CGRectGetMinY(frame) - height;
    CGFloat bottomDeltaH = ZLPopBubbleScreenHeight - CGRectGetMaxY(frame) - height;
    if (topDeltaH < 0 && bottomDeltaH < 0) {
        ZLLog(@"ZLPopBubbleView---Error - - 由于位置和大小的问题，popBubbleView将无法显示");
        return ZLPopBubbleViewDirectionError;
    }
    if (topDeltaH > bottomDeltaH) {
        return ZLPopBubbleViewDirectionTop;
    }else {
        return ZLPopBubbleViewDirectionBottom;
    }
}

+ (CGPoint)p_zl_getPopBubbleViewArrowPointWithRect:(CGRect)frame showingViewH:(CGFloat)showingViewH {
    CGPoint p = CGPointZero;
    
    if ([self p_zl_getPopBubbleViewDirectionWithRect:frame showingViewH:showingViewH] == ZLPopBubbleViewDirectionBottom) {
        p = CGPointMake(frame.size.width/2.f + CGRectGetMinX(frame), CGRectGetMaxY(frame));
    }else if ([self p_zl_getPopBubbleViewDirectionWithRect:frame showingViewH:showingViewH] == ZLPopBubbleViewDirectionTop) {
        p = CGPointMake(frame.size.width/2.f + CGRectGetMinX(frame), CGRectGetMinY(frame));
    }
    return p;
}

- (void)p_zl_clickView {
    if (self.viewClicked) {
        self.viewClicked();
    }
}
#pragma mark - 外部方法
+ (instancetype)popBubbleWithView:(UIView *)view showingView:(UIView *)showingView showingViewH:(CGFloat)showingViewH {
    ZLPopBubbleController *vc = [[ZLPopBubbleController alloc] init];
    CGRect newFrame = [vc.view convertRect:view.frame fromView:view.superview];
    
    vc.showFrame = [self p_zl_getPopBubbleViewFrameWithRect:newFrame showingViewH:showingViewH];
    
    vc.smallFrame = CGRectMake(vc.showFrame.origin.x, vc.showFrame.origin.y, vc.showFrame.size.width, 10.f);
    vc.popBubbleView.frame = vc.showFrame;
    vc.popBubbleView.arrowPointX = [self p_zl_getPopBubbleViewArrowPointWithRect:newFrame showingViewH:showingViewH].x;
    vc.popBubbleView.direction = [self p_zl_getPopBubbleViewDirectionWithRect:newFrame showingViewH:showingViewH];
    vc.popBubbleView.showingView = showingView;
    [vc p_zl_animShowPopBubbleViewCompletion:nil];
    return vc;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WeakSelf;
    [self p_zl_animHidePopBubbleViewCompletion:^{
        [weakSelf p_zl_clickView];
    }];
    
}


@end
