//
//  ZLPopoverView.h
//  YunDuoYouBao
//
//  Created by Harley He on 18/11/2017.
//  Copyright © 2017 Harley He. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDYBWeBussinessModel,YDYBWeBussinessSpecificationsModel;

@interface ZLPopBubbleView : NSObject

/**
 单例
 */
+ (instancetype)sharedInstance;
- (void)hide;
- (void)showLoadingWithType:(ZLLoadingType)loadingType viewTouched:(void(^)(void))viewTouched;
- (void)hideLoading;


#pragma mark - 显示popBubbleView
/**
 显示popBubbleView

 @param view 显示在哪个view下面或者上面
 @param showingView 要显示的view
 @param showingViewH 要显示view的高度
 */
- (void)showPopBubbleViewWithView:(UIView *)view showingView:(UIView *)showingView showingViewH:(CGFloat)showingViewH;
- (void)showPopBubbleViewWithView:(UIView *)view showingView:(UIView *)showingView;
@end
