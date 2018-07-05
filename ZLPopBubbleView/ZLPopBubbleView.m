//
//  ZLPopBubbleView.m
//  TYWJBus
//
//  Created by Harley He on 2018/6/20.
//  Copyright © 2018 Harley He. All rights reserved.
//

#import "ZLPopBubbleView.h"

static CGFloat ZLPopBubbleViewRectangleY = 10.f;
static CGFloat ZLPopBubbleViewArcW = 6.f;
static CGFloat ZLPopBubbleViewArcRadius = 6.f;


@implementation ZLPopBubbleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    if (!self.viewColor) {
        self.viewColor = [UIColor whiteColor];
    }
    [self drawTriangle];
//    [self drawRectangle];
//    [self setShowingViewF];
}

- (void)drawTriangle {
    
    if (self.direction == ZLPopBubbleViewDirectionBottom) {
        CGFloat x = self.arrowPointX - self.frame.origin.x;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(x, 0)];
        [bezierPath addLineToPoint:CGPointMake(x - ZLPopBubbleViewArcW, ZLPopBubbleViewRectangleY)];
        [bezierPath addLineToPoint:CGPointMake(x + ZLPopBubbleViewArcW, ZLPopBubbleViewRectangleY)];
        
        [self.viewColor set];
        [bezierPath fill];
    }else {
        CGFloat x = self.arrowPointX - self.frame.origin.x;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(x, self.frame.size.height)];
        [bezierPath addLineToPoint:CGPointMake(x - ZLPopBubbleViewArcW, ZLPopBubbleViewRectangleY)];
        [bezierPath addLineToPoint:CGPointMake(x + ZLPopBubbleViewArcW, ZLPopBubbleViewRectangleY)];
        
        [self.viewColor set];
        [bezierPath fill];
    }
}

- (void)drawRectangle {
    if (self.direction == ZLPopBubbleViewDirectionBottom) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, ZLPopBubbleViewRectangleY, self.zl_width, self.zl_height - ZLPopBubbleViewRectangleY) cornerRadius:ZLPopBubbleViewArcRadius];
        
        [self.viewColor set];
        [bezierPath fill];
    }else {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.zl_width, self.zl_height - ZLPopBubbleViewRectangleY) cornerRadius:ZLPopBubbleViewArcRadius];
        
        [self.viewColor set];
        [bezierPath fill];
    }
    
}

- (void)addContentView {
    UIView *contentView = [[UIView alloc] init];
    
    if (self.direction == ZLPopBubbleViewDirectionBottom) {
        contentView.frame = CGRectMake(0, ZLPopBubbleViewRectangleY - 1, self.zl_width, self.zl_height - ZLPopBubbleViewRectangleY);
    }else {
        contentView.frame = CGRectMake(0, 0, self.zl_width, self.zl_height - ZLPopBubbleViewRectangleY);
    }
    contentView.backgroundColor = self.viewColor;
    [contentView setRoundViewWithCornerRaidus:ZLPopBubbleViewArcRadius];
    [self addSubview:contentView];
    self.contentView = contentView;
    [self setShowingViewF];
    
    [_showingView setRoundViewWithCornerRaidus:ZLPopBubbleViewArcRadius];
    [contentView addSubview:_showingView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setShowingView:(UIView *)showingView {
    _showingView = showingView;
    
    [self addContentView];
}

- (void)setShowingViewF {
    _showingView.zl_width = self.contentView.zl_width - 2.f;
    _showingView.zl_height = self.contentView.zl_height - 2.f;
    _showingView.zl_y = 1.f;
    _showingView.zl_x = 1.f;
}

- (void)dealloc {
    ZLFuncLog;
}
@end
