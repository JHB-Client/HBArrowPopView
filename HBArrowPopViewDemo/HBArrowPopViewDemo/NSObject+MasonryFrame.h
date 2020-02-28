//
//  NSObject+MasonryFrame.h
//  HBArrowPopViewDemo
//
//  Created by admin on 2020/2/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MasonryFrame)
void didLayout(void(^layout)(void));
@end

NS_ASSUME_NONNULL_END
