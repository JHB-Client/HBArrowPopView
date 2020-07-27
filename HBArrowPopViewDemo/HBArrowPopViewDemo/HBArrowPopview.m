//
//  HBArrowPopview.m
//  HBArrowPopViewDemo
//
//  Created by admin on 2020/2/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import "HBArrowPopview.h"
@interface HBArrowPopview()
@property (nonatomic, assign) CGPoint peakPoint;
@property (nonatomic, assign) CGSize containerViewSize;
@property (nonatomic, assign) HBPopviewArrowDirection arrowDirection;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGPoint contentOriginPoint;
@property (nonatomic, strong) CAShapeLayer *arrowLayer;
@property (nonatomic, strong) UIView *targetView;
@end
@implementation HBArrowPopview
#pragma mark -- 1:初始化
- (instancetype)initWithArrowPeakPoint:(CGPoint)peakPoint containerViewSize:(CGSize)containerViewSize arrowDirection:(HBPopviewArrowDirection)arrowDirection {
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.containerViewRadius = 5.0;
        self.arrowWidth = 20;
        if (self.arrowOffSet == 0) {
            self.arrowOffSet = self.containerViewRadius + 15;
        }
        self.arrowHeight = 10;
        
        self.arrowDirection = arrowDirection;
        self.peakPoint = peakPoint;
        self.containerViewSize = containerViewSize;
        [self setupInit];
        [self addSubview:self.containerView];
    }
    return self;
}

- (instancetype)initWithTargetView:(UIView *)targetView containerViewSize:(CGSize)containerViewSize {
    
    self.containerViewRadius = 5.0;
    self.arrowWidth = 20;
    self.arrowOffSet = targetView.bounds.size.width * 0.5 - self.arrowWidth * 0.5;
    self.arrowHeight = 10;
    self.targetView = targetView;
    
    HBPopviewArrowDirection arrowDirection = [self arrowDirection:targetView arrowViewSize:containerViewSize];
    
    CGPoint peakPoint = [self arrowPeakPointWithTargetView:targetView arrowDirection:arrowDirection];
    
    return [self initWithArrowPeakPoint:peakPoint containerViewSize:containerViewSize arrowDirection:arrowDirection];
}

- (CGPoint)arrowPeakPointWithTargetView:(UIView *)targetView arrowDirection:(HBPopviewArrowDirection)arrowDirection {
    //
    CGPoint peakPoint;
    CGFloat marginOffset = 5;
    switch (arrowDirection) {
        case HBPopviewArrowDirectionLeftTop:
        case HBPopviewArrowDirectionLeftBottom:{
            CGFloat peakPointX = CGRectGetMaxX(targetView.frame) + marginOffset;
            CGFloat peakPointY = CGRectGetMidY(targetView.frame);
            peakPoint = CGPointMake(peakPointX, peakPointY);
        }
        break;
        case HBPopviewArrowDirectionRightTop:
        case HBPopviewArrowDirectionRightBottom:{
        CGFloat peakPointX = targetView.frame.origin.x - marginOffset;
        CGFloat peakPointY = CGRectGetMidY(targetView.frame);
        peakPoint = CGPointMake(peakPointX, peakPointY);
        }
        break;
        case HBPopviewArrowDirectionTopLeft:
        case HBPopviewArrowDirectionTopCenter:
        case HBPopviewArrowDirectionTopRight:{
        CGFloat peakPointX = CGRectGetMidX(targetView.frame);
        CGFloat peakPointY = CGRectGetMaxY(targetView.frame) + marginOffset;
        peakPoint = CGPointMake(peakPointX, peakPointY);
        }
        break;
        case HBPopviewArrowDirectionBottomLeft:
        case HBPopviewArrowDirectionBottomCenter:
        case HBPopviewArrowDirectionBottomRight:{
        CGFloat peakPointX = CGRectGetMidX(targetView.frame);
            CGFloat peakPointY = targetView.frame.origin.y - marginOffset;
        peakPoint = CGPointMake(peakPointX, peakPointY);
        }
        break;
            
        default:
        peakPoint = CGPointZero;
        break;
    }
    
    return peakPoint;
}


#pragma mark -- 箭头位置
- (HBPopviewArrowDirection)arrowDirection:(UIView *)targetView arrowViewSize:(CGSize)size {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat targetViewX = targetView.frame.origin.x;
    CGFloat targetViewY = targetView.frame.origin.y;
    CGFloat targetViewMidX = CGRectGetMidX(targetView.frame);
    CGFloat targetViewMidY = CGRectGetMidY(targetView.frame);
    CGFloat targetViewMaxX = CGRectGetMaxX(targetView.frame);
    CGFloat targetViewMaxY = CGRectGetMaxY(targetView.frame);
    CGFloat screenMidX = screenW * 0.5;
    CGFloat screenMidY = screenH * 0.5;
    CGFloat arrowViewW = size.width;
    CGFloat arrowViewH = size.height;
    
    NSLog(@"---self.arrowWidth---:%lf", self.arrowWidth * 0.5);
    // 高度太小--上
    if (targetViewMidY <= self.arrowWidth * 0.5 + self.arrowOffSet + 64) {
        if (targetViewMidX < arrowViewW * 0.5) {
            NSLog(@"--高度太小--上左");
            return HBPopviewArrowDirectionTopLeft;
        } else if(targetViewMidX < screenW - arrowViewW * 0.5) {
            NSLog(@"--高度太小--上中");
            return HBPopviewArrowDirectionTopCenter;
        } else {
            NSLog(@"--高度太小--上右");
            return HBPopviewArrowDirectionTopRight;
        }
    }
    
    
    // 高度太小--下
    if (screenH - targetViewMidY - self.arrowWidth * 0.5 < self.arrowOffSet) {
       if (targetViewMidX < arrowViewW * 0.5) {
           NSLog(@"--高度太小--下左");
           return HBPopviewArrowDirectionBottomLeft;
       } else if(targetViewMidX < screenW - arrowViewW * 0.5) {
           NSLog(@"--高度太小--下中");
           return HBPopviewArrowDirectionBottomCenter;
       } else {
           NSLog(@"--高度太小--下右");
           return HBPopviewArrowDirectionBottomRight;
       }
   }


    // 其他
    if(screenW - targetViewMaxX > arrowViewW) {// 右边宽
        if(targetViewX > arrowViewW) { //左边也宽
        
            
                if(targetViewMidX > screenMidX) {//中线靠右
                            // 左
                    if(targetViewMidY - self.arrowOffSet  >  screenMidY){
                                    // 左下
                                      NSLog(@"----左下");
                                return HBPopviewArrowDirectionLeftBottom;
                                    }else{
                                        //左上
                                        NSLog(@"----左上");
                                        return HBPopviewArrowDirectionLeftTop;
                                    }
                }else {//左边宽
                            // 右
                            if(targetViewMidY - self.arrowOffSet  >  screenMidY){
                            // 下右
                                NSLog(@"----下右");
                                return HBPopviewArrowDirectionBottomRight;
                            }else{
                            //上右
                                NSLog(@"----上右");
                                return HBPopviewArrowDirectionTopRight;
                            }
                }
        } else { //左边窄
            
            if (targetViewMaxX + arrowViewW + 5 > screenW) {
                if(screenH - targetViewMaxY > arrowViewH) { // 下面宽
                    if(targetViewMidY  >  screenMidY) { // 上面宽
                        //下
                        NSLog(@"----下中");
                        return HBPopviewArrowDirectionBottomCenter;
                    }else{ // 上面窄
                        // 上
                        NSLog(@"----上中");
                        return HBPopviewArrowDirectionTopCenter;
                    }
                } else { // 下面窄
                    if(targetViewY  > arrowViewH ) { // 上面宽
                        //下
                        NSLog(@"----下中");
                        return HBPopviewArrowDirectionBottomCenter;
                    }else{ // // 上面窄
                        // 无解
                        NSLog(@"----无解");
                        return HBPopviewArrowDirectionBottomCenter;
                    }
                }
            }
            
            // 左
            if(targetViewMidY - self.arrowOffSet>  screenMidY){
                // 左下
                NSLog(@"----左下");
                return HBPopviewArrowDirectionLeftBottom;
            }else{
                //左上
                NSLog(@"----左上");
                return HBPopviewArrowDirectionLeftTop;
            }
        }
    
    }else { // 右边窄
        if(targetViewX > arrowViewW) { // 左边宽
            // 右
            if(targetViewMidY - self.arrowOffSet  >  screenMidY){
                // 下右
                NSLog(@"----右下");
                return HBPopviewArrowDirectionRightBottom;
            }else{
                //上右
                NSLog(@"----右上");
                return HBPopviewArrowDirectionRightTop;
            }
    
        } else {
            // 上下
            if(screenH - targetViewMaxY > arrowViewH) { // 下面宽
                if(targetViewMidY  >  screenMidY) { // 上面宽
                    //下
                    NSLog(@"----下中");
                    return HBPopviewArrowDirectionBottomCenter;
                }else{ // 上面窄
                    // 上
                    NSLog(@"----上中");
                    return HBPopviewArrowDirectionTopCenter;
                }
            } else { // 下面窄
                if(targetViewY  > arrowViewH ) { // 上面宽
                    //下
                    NSLog(@"----下中");
                    return HBPopviewArrowDirectionBottomCenter;
                }else{ // // 上面窄
                    // 无解
                    NSLog(@"----无解");
                    return HBPopviewArrowDirectionBottomCenter;
                }
            }
        }
    }
}


- (void)setupInit {
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

- (void)setArrowOffSet:(CGFloat)arrowOffSet {
    _arrowOffSet = arrowOffSet;
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
//    CGFloat arrowOffSet = self.arrowOffSet;
    CGFloat containerViewW = self.containerViewSize.width;
    CGFloat containerViewH = self.containerViewSize.height;
    self.containerView.layer.cornerRadius = self.containerViewRadius;
    self.containerView.layer.masksToBounds = true;
    CGFloat arrowOffSet = self.targetView.bounds.size.height > self.targetView.bounds.size.width ? self.targetView.bounds.size.height * 0.5 - self.arrowWidth * 0.5 : self.targetView.bounds.size.width * 0.5 - self.arrowWidth * 0.5;
    arrowOffSet = arrowOffSet >= 20 ? 20 : arrowOffSet;
    arrowOffSet = arrowOffSet <= self.arrowWidth * 0.5 ? self.arrowWidth * 0.5 : arrowOffSet;
    switch (_arrowDirection) {
        case HBPopviewArrowDirectionTopLeft:
            self.contentOriginPoint = CGPointMake(peakPX - arrowW * 0.5 - arrowOffSet, peakPY + arrowH);
            break;
        case HBPopviewArrowDirectionTopCenter:
            self.contentOriginPoint = CGPointMake(peakPX - containerViewW * 0.5, peakPY + arrowH);
            break;
        case HBPopviewArrowDirectionTopRight:
            self.contentOriginPoint = CGPointMake(peakPX + arrowW * 0.5 + arrowOffSet - containerViewW, peakPY + arrowH);
            break;
        case HBPopviewArrowDirectionLeftTop:
            self.contentOriginPoint = CGPointMake(peakPX + arrowH, peakPY - arrowOffSet - arrowW * 0.5);
            break;
        case HBPopviewArrowDirectionLeftCenter:
            self.contentOriginPoint = CGPointMake(peakPX + arrowH, peakPY - containerViewH * 0.5);
            break;
        case HBPopviewArrowDirectionLeftBottom:
            self.contentOriginPoint = CGPointMake(peakPX + arrowH, peakPY + arrowOffSet - containerViewH + arrowW * 0.5);
            break;
        case HBPopviewArrowDirectionBottomLeft:
            self.contentOriginPoint = CGPointMake(peakPX - arrowW * 0.5 - arrowOffSet, peakPY - arrowH - containerViewH);
            break;
        case HBPopviewArrowDirectionBottomCenter:
            self.contentOriginPoint = CGPointMake(peakPX - containerViewW * 0.5, peakPY - arrowH - containerViewH);
            break;
        case HBPopviewArrowDirectionBottomRight:
            self.contentOriginPoint = CGPointMake(peakPX + arrowW * 0.5 + arrowOffSet - containerViewW, peakPY - arrowH - containerViewH);
            break;
        case HBPopviewArrowDirectionRightBottom:
            self.contentOriginPoint = CGPointMake(peakPX - arrowH - containerViewW, peakPY + arrowOffSet - containerViewH + arrowW * 0.5);
            break;
        case HBPopviewArrowDirectionRightCenter:
            self.contentOriginPoint = CGPointMake(peakPX - arrowH - containerViewW, peakPY - containerViewH * 0.5);
            break;
        case HBPopviewArrowDirectionRightTop:
            self.contentOriginPoint = CGPointMake(peakPX - arrowH - containerViewW, peakPY - arrowOffSet - arrowW * 0.5 - arrowOffSet);
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
            CGFloat originPY = containerViewY + 0.5;
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
            
            CGFloat originPX = containerViewX + 0.5;
            CGFloat originPY = peakPY + arrowW * 0.5;
            CGPoint originP = CGPointMake(originPX, originPY);
            
            CGFloat terminusPX = originPX;
            CGFloat terminusPY = peakPY - arrowW * 0.5;
            CGPoint terminusP = CGPointMake(terminusPX, terminusPY);
            [self drawArrowWithOriginPoint:originP peakPoint:self.peakPoint terminusPoint:terminusP];
        }
            break;
        case HBPopviewArrowDirectionBottomLeft:
        case HBPopviewArrowDirectionBottomCenter:
        case HBPopviewArrowDirectionBottomRight: {
            
            CGFloat originPX = peakPX - arrowW * 0.5;
            CGFloat originPY = peakPY - arrowH - 0.5;
            CGPoint originP = CGPointMake(originPX, originPY);
            
            CGFloat terminusPX = peakPX + arrowW * 0.5;
            CGFloat terminusPY = originPY;
            CGPoint terminusP = CGPointMake(terminusPX, terminusPY);
            [self drawArrowWithOriginPoint:originP peakPoint:self.peakPoint terminusPoint:terminusP];
        }
            break;
        case HBPopviewArrowDirectionRightBottom:
        case HBPopviewArrowDirectionRightCenter:
        case HBPopviewArrowDirectionRightTop: {
            
            CGFloat originPX = peakPX - arrowH - 0.5;
            CGFloat originPY = peakPY - arrowW * 0.5;
            CGPoint originP = CGPointMake(originPX, originPY);
            
            CGFloat terminusPX = originPX;
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
