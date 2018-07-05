//
//  ZLPopover.h
//  TYWJBus
//
//  Created by Harley He on 2018/6/20.
//  Copyright © 2018 Harley He. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZLPopBubbleViewDirectionError = 0,
    ZLPopBubbleViewDirectionTop = 1001,
    ZLPopBubbleViewDirectionBottom
} ZLPopBubbleViewDirection;

@interface ZLPopover : UIView

/* showingView */
@property (strong, nonatomic) UIView *showingView;
/* 箭头显示坐标 */
@property (assign, nonatomic) CGFloat arrowPointX;
/* ZLPopBubbleViewDirection */
@property (assign, nonatomic) ZLPopBubbleViewDirection direction;
/* viewColcor */
@property (strong, nonatomic) UIColor *viewColor;
/* contentView */
@property (strong, nonatomic) UIView *contentView;
@end
