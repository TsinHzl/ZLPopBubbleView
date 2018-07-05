//
//  ZLPopBubbleController.h
//  TYWJBus
//
//  Created by Harley He on 2018/6/20.
//  Copyright © 2018 Harley He. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPopBubbleController : UIViewController

/**
 显示popBubbleView

 @param view 要显示在哪个view下面或者上面
 @param showingView 要显示的view
 @return ZLPopBubbleController
 */
+ (instancetype)popBubbleWithView:(UIView *)view showingView:(UIView *)showingView showingViewH:(CGFloat)showingViewH;

/* viewClicked */
@property (copy, nonatomic) void(^viewClicked)(void);

@end
