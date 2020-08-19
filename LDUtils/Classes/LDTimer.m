//
//  LDTimer.m
//  LDTimer
//
//  Created by jz on 2020/8/12.
//  Copyright © 2020 jz. All rights reserved.
//

#import "LDTimer.h"

static NSMutableDictionary *timers_;
static dispatch_semaphore_t semaphore_;

@implementation LDTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}


+ (NSString *)excelTask:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    // 创建队列
    dispatch_queue_t queue = async ? dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL): dispatch_get_main_queue();
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    // 加锁
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *identify = [NSString stringWithFormat:@"%lu", (unsigned long)timers_.count];
    // 存储定时
    timers_[identify] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:identify];
        }
    });
    dispatch_resume(timer);
    
    return identify;
}

+ (NSString *)excelTarget:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    
    if (!target || !selector) return nil;
    
    return [self excelTask:^{
        
        if ([target respondsToSelector:selector]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
            #pragma clang diagnostic pop
        }
        
    } start:start interval:interval repeats:repeats async:async];
}

+ (void)cancelTask:(NSString *)taskName {
    
    if (taskName.length == 0) return;
    
    // 加锁
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timers_[taskName];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:taskName];
    }
    dispatch_semaphore_signal(semaphore_);
}

@end
