//
//  ViewController.m
//  HBArrowPopViewDemo
//
//  Created by admin on 2020/2/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ViewController.h"
#import "HBArrowPopview.h"

#define yt_px(x)
@interface ViewController ()
@property (nonatomic, strong) HBArrowPopview *popView;
@property (nonatomic, strong) UILabel *label1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 200, 10)];
    self.label1.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.label1];
    
    CGFloat screenScale = [UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height;
    CGFloat arrowWidth = 25 * screenScale;
    CGFloat arrowHeight = 15 * screenScale;


    self.popView = [[HBArrowPopview alloc] initWithTargetView:self.label1 containerViewSize:CGSizeMake(arrowWidth * 10, arrowHeight * 25)];
    
    //
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    self.popView.contentView = btn;
    [self.popView showArrowPopView];
}

- (void)test:(UIButton *)btn {
    [self.label1 removeFromSuperview];
    [self.popView removeFromSuperview];
    //
    CGFloat x = arc4random() % 376;
    CGFloat y = arc4random() % 668;
    CGFloat w = arc4random() % 376;
    CGFloat h = arc4random() % 668;
   
    if (w + x > 375) {
        if (w > x) {
            w = 375 - x;
        } else {
            x = 375 - w;
        }
    }
    
    if (h + y > 667) {
        if (h > y) {
            h = 667 - y;
        } else {
            y = 667 - h;
        }
    }
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.label1.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.label1];
    
    CGFloat screenScale = [UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height;
    CGFloat arrowWidth = 25 * screenScale;
    CGFloat arrowHeight = 15 * screenScale;


    self.popView = [[HBArrowPopview alloc] initWithTargetView:self.label1 containerViewSize:CGSizeMake(arrowWidth * 10, arrowHeight * 25)];
    
    //
    UIButton *btn2 = [UIButton new];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    self.popView.contentView = btn2;
    [self.popView showArrowPopView];
}


@end
