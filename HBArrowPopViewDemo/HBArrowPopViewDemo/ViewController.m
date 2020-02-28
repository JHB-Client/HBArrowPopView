//
//  ViewController.m
//  HBArrowPopViewDemo
//
//  Created by admin on 2020/2/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "HBArrowPopview.h"

#define yt_px(x)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat screenScale = [UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height;
    CGFloat arrowWidth = 15 * screenScale;
    CGFloat arrowHeight = 10 * screenScale;
    
    HBArrowPopview *popView = [[HBArrowPopview alloc] initWithArrowPeakPoint:CGPointMake(300, 200) containerViewSize:CGSizeMake(arrowWidth * 20, arrowHeight * 40) arrowDirection:HBPopviewArrowDirectionRightTop];
    
    popView.arrowWidth = arrowWidth;
    popView.arrowHeight = arrowHeight;
    
    UILabel *label = [UILabel new];
    label.text = @"你啊回家";
    label.backgroundColor = [UIColor greenColor];
    label.textColor = [UIColor redColor];
    popView.contentView = label;
    [popView showArrowPopView];
}
@end
