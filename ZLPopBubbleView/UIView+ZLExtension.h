//
//  UIView+ZLExtension.h
//
//  Created by Harley He on 16/8/12.
//  Copyright © 2016年 Harley He. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZLExtension)

@property(nonatomic, assign)CGFloat zl_x;
@property(nonatomic, assign)CGFloat zl_y;
@property(nonatomic, assign)CGPoint zl_origin;

@property(nonatomic, assign)CGFloat zl_width;
@property(nonatomic, assign)CGFloat zl_height;
@property(nonatomic, assign)CGSize zl_size;

@property(nonatomic, assign)CGFloat zl_centerX;
@property(nonatomic, assign)CGFloat zl_centerY;

@property(nonatomic, assign)CGFloat zl_rightLine;
@property(nonatomic, assign)CGFloat zl_bottmLine;

- (void)setRoundViewWithCornerRaidus:(CGFloat)cornerRadius;
- (void)setRoundView;

- (void)setBorderWithColor:(UIColor *)color;
/**
 *  @判断view是否显示
 */
- (BOOL)isShowingOnKeyWindow;

@end
