//
//  HBArrowPopview.m
//  HBArrowPopViewDemo
//
//  Created by admin on 2020/2/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import "HBArrowPopview.h"
#define DISTANCE (self.containerViewRadius + 15)

@interface HBArrowPopview()
@property (nonatomic, assign) CGPoint peakPoint;
@property (nonatomic, assign) CGSize containerViewSize;
@property (nonatomic, assign) HBPopviewArrowDirection arrowDirection;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGPoint contentOriginPoint;
@property (nonatomic, strong) CAShapeLayer *arrowLayer;
@end
@implementation HBArrowPopview
#pragma mark -- 1:初始化
- (instancetype)initWithArrowPeakPoint:(CGPoint)peakPoint containerViewSize:(CGSize)containerViewSize arrowDirection:(HBPopviewArrowDirection)arrowDirection {
    if (self = [super initWithFrame:CGRectZero]) {
        self.arrowDirection = arrowDirection;
        self.peakPoint = peakPoint;
        self.containerViewSize = containerViewSize;
        [self setupInit];
        [self addSubview:self.containerView];
    }
    return self;
}


- (void)setupInit {
    //
    self.containerViewRadius = 5.0;
    self.arrowWidth = 20;
    self.arrowHeight = 10;
    //
    self.bgAlpha = 0.5;
    self.containerViewBgColor = [UIColor whiteColor];
    //
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //
    self.containerView.layer.cornerRadius = self.containerViewRadius;
    self.containerView.layer.masksToBounds = true;
    self.containerView.backgroundColor = self.containerViewBgColor;
}


- (void)setArrowWidth:(CGFloat)arrowWidth {
    _arrowWidth = arrowWidth;
    [self setContainerViewFrame];
}

- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self setContainerViewFrame];
}

- (void)setcontainerViewRadius:(CGFloat)containerViewRadius {
    _containerViewRadius = containerViewRadius;
    [self setContainerViewFrame];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:[UIScreen mainScreen].bounds];
}


- (void)setContainerViewFrame {
    
    CGFloat peakPX = self.peakPoint.x;
    CGFloat peakPY = self.peakPoint.y;
    CGFloat arrowW = self.arrowWidth;
    CGFloat arrowH = self.arrowHeight;
    CGFloat containerViewW = self.containerViewSize.width;
    CGFloat containerViewH = self.containerViewSize.height;
   
    switch (_arrowDirection) {
        case HBPopviewArrowDirectionTopLeft:
            self.contentOriginPoint = CGPointMake(peakPX - arrowW * 0.5 - DISTANCE, peakPY + arrowH);
            break;
        case HBPopviewArrowDirectionTopCenter:
            self.contentOriginPoint = CGPointMake(peakPX - containerViewW * 0.5, peakPY + arrowH);
            break;
        case HBPopviewArrowDirectionTopRight:
            self.contentOriginPoint = CGPointMake(peakPX + arrowW * 0.5 + DISTANCE - containerViewW, peakPY + arrowH);
            break;
        case HBPopviewArrowDirectionLeftTop:
            self.contentOriginPoint = CGPointMake(peakPX + arrowH, peakPY - DISTANCE);
            break;
        case HBPopviewArrowDirectionLeftCenter:
            self.contentOriginPoint = CGPointMake(peakPX + arrowH, peakPY - containerViewH * 0.5);
            break;
        case HBPopviewArrowDirectionLeftBottom:
            self.contentOriginPoint = CGPointMake(peakPX + arrowH, peakPY + DISTANCE - containerViewH);
            break;
        case HBPopviewArrowDirectionBottomLeft:
            self.contentOriginPoint = CGPointMake(peakPX - arrowW * 0.5 - DISTANCE, peakPY - arrowH - containerViewH);
            break;
        case HBPopviewArrowDirectionBottomCenter:
            self.contentOriginPoint = CGPointMake(peakPX - containerViewW * 0.5, peakPY - arrowH - containerViewH);
            break;
        case HBPopviewArrowDirectionBottomRight:
            self.contentOriginPoint = CGPointMake(peakPX + arrowW * 0.5 + DISTANCE - containerViewW, peakPY - arrowH - containerViewH);
            break;
        case HBPopviewArrowDirectionRightBottom:
            self.contentOriginPoint = CGPointMake(peakPX - arrowH - containerViewW, peakPY + DISTANCE - containerViewH);
            break;
        case HBPopviewArrowDirectionRightCenter:
            self.contentOriginPoint = CGPointMake(peakPX - arrowH - containerViewW, peakPY - containerViewH * 0.5);
            break;
        case HBPopviewArrowDirectionRightTop:
            self.contentOriginPoint = CGPointMake(peakPX - arrowH - containerViewW, peakPY - DISTANCE);
            break;
        }
    
    self.containerView.frame = CGRectMake(self.contentOriginPoint.x, self.contentOriginPoint.y, containerViewW, containerViewH);
    
    if (![self.containerView.subviews containsObject:self.contentView]) {
        [self.containerView addSubview:self.contentView];
    }
    self.contentView.frame = CGRectMake(3, 3, containerViewW - 6, containerViewH - 6);
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    [self setContainerViewFrame];
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [UIView new];
    }
    return _containerView;
}


#pragma mark -- 2:显示
- (void)showArrowPopView {
    //1.绘制箭头
    [self calculateArrowPointsPositionWithDirection:self.arrowDirection];
    //2.添加蒙版到keyWindow
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self bringSubviewToFront:keyWindow];
}

- (void)calculateArrowPointsPositionWithDirection:(HBPopviewArrowDirection)arrowDirection {
    CGFloat peakPX = self.peakPoint.x;
    CGFloat peakPY = self.peakPoint.y;
    CGFloat arrowW = self.arrowWidth;
    CGFloat arrowH = self.arrowHeight;
    CGFloat containerViewX = self.containerView.frame.origin.x;
    CGFloat containerViewY = self.containerView.frame.origin.y;
    
    switch (arrowDirection) {
        case HBPopviewArrowDirectionTopLeft:
        case HBPopviewArrowDirectionTopCenter:
        case HBPopviewArrowDirectionTopRight:{
            CGFloat originPX = peakPX - arrowW * 0.5;
            CGFloat originPY = containerViewY;
            CGPoint originP = CGPointMake(originPX, originPY);
            
            CGFloat terminusPX = peakPX + arrowW * 0.5;
            CGFloat terminusPY = originPY;
            CGPoint terminusP = CGPointMake(terminusPX, terminusPY);
            [self drawArrowWithOriginPoint:originP peakPoint:self.peakPoint terminusPoint:terminusP];
        }
            break;
        case HBPopviewArrowDirectionLeftTop:
        case HBPopviewArrowDirectionLeftCenter:
        case HBPopviewArrowDirectionLeftBottom: {
            
            CGFloat originPX = containerViewX;
            CGFloat originPY = peakPY + arrowW * 0.5;
            CGPoint originP = CGPointMake(originPX, originPY);
            
            CGFloat terminusPX = containerViewX;
            CGFloat terminusPY = peakPY - arrowW * 0.5;
            CGPoint terminusP = CGPointMake(terminusPX, terminusPY);
            [self drawArrowWithOriginPoint:originP peakPoint:self.peakPoint terminusPoint:terminusP];
        }
            break;
        case HBPopviewArrowDirectionBottomLeft:
        case HBPopviewArrowDirectionBottomCenter:
        case HBPopviewArrowDirectionBottomRight: {
            
            CGFloat originPX = peakPX - arrowW * 0.5;
            CGFloat originPY = peakPY - arrowH;
            CGPoint originP = CGPointMake(originPX, originPY);
            
            CGFloat terminusPX = peakPX + arrowW * 0.5;
            CGFloat terminusPY = peakPY - arrowH;
            CGPoint terminusP = CGPointMake(terminusPX, terminusPY);
            [self drawArrowWithOriginPoint:originP peakPoint:self.peakPoint terminusPoint:terminusP];
        }
            break;
        case HBPopviewArrowDirectionRightBottom:
        case HBPopviewArrowDirectionRightCenter:
        case HBPopviewArrowDirectionRightTop: {
            
            CGFloat originPX = peakPX - arrowH;
            CGFloat originPY = peakPY - arrowW * 0.5;
            CGPoint originP = CGPointMake(originPX, originPY);
            
            CGFloat terminusPX = peakPX - arrowH;
            CGFloat terminusPY = peakPY + arrowW * 0.5;
            CGPoint terminusP = CGPointMake(terminusPX, terminusPY);
            [self drawArrowWithOriginPoint:originP peakPoint:self.peakPoint terminusPoint:terminusP];
        }
            break;
    }
}


- (void)drawArrowWithOriginPoint:(CGPoint)originPoint peakPoint:(CGPoint)peakPoint terminusPoint:(CGPoint)terminusPoint {
    self.arrowLayer = [CAShapeLayer layer];
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    [arrowPath moveToPoint:originPoint];
    [arrowPath addLineToPoint:peakPoint];
    [arrowPath addLineToPoint:terminusPoint];
    
    self.arrowLayer.path = arrowPath.CGPath;
    [arrowPath closePath];
    self.arrowLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.arrowLayer];
}
@end
