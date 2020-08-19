//
//  LDTimer.h
//  LDTimer
//
//  Created by jz on 2020/8/12.
//  Copyright © 2020 jz. All rights reserved.
//
//  GCD定时器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDTimer : NSObject

+ (NSString *)executeTask:(void(^)(void))task
            start:(NSTimeInterval)start
         interval:(NSTimeInterval)interval
          repeats:(BOOL)repeats
            async:(BOOL)async;

+ (NSString *)executeTarget:(id)target
    selector:(SEL)selector
   start:(NSTimeInterval)start
interval:(NSTimeInterval)interval
 repeats:(BOOL)repeats
   async:(BOOL)async;

+ (void)cancelTask:(NSString *)taskName;

@end

NS_ASSUME_NONNULL_END
