//
//  HBArrowPopview.h
//  HBArrowPopViewDemo
//
//  Created by admin on 2020/2/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HBPopviewArrowDirection){
    // 上(左中右)
    HBPopviewArrowDirectionTopLeft = 0,
    HBPopviewArrowDirectionTopCenter,
    HBPopviewArrowDirectionTopRight,
    // 左(上中下)
    HBPopviewArrowDirectionLeftTop,
    HBPopviewArrowDirectionLeftCenter,
    HBPopviewArrowDirectionLeftBottom,
    // 下(左中右)
    HBPopviewArrowDirectionBottomLeft,
    HBPopviewArrowDirectionBottomCenter,
    HBPopviewArrowDirectionBottomRight,
    // 右(下中上)
    HBPopviewArrowDirectionRightBottom,
    HBPopviewArrowDirectionRightCenter,
    HBPopviewArrowDirectionRightTop,
};

@interface HBArrowPopview : UIView
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, assign) CGFloat containerViewRadius;
@property (nonatomic, assign) CGFloat bgAlpha;
@property (nonatomic, strong) UIColor *containerViewBgColor;
@property (nonatomic, strong) UIView *contentView;
//
- (instancetype)initWithArrowPeakPoint:(CGPoint)peakPoint containerViewSize:(CGSize)containerViewSize arrowDirection:(HBPopviewArrowDirection)arrowDirection;
- (void)showArrowPopView;
@end

NS_ASSUME_NONNULL_END
