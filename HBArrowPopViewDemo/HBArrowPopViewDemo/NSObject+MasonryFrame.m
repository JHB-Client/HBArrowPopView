//
//  NSObject+MasonryFrame.m
//  HBArrowPopViewDemo
//
//  Created by admin on 2020/2/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import "NSObject+MasonryFrame.h"

@implementation NSObject (MasonryFrame)
void didLayout(void(^layout)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (layout) {
            layout();
        }
    });
}
@end
