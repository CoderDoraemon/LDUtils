//
//  LDPThreadMutexConditionDemo.m
//  LDUtils_Example
//
//  Created by jz on 2020/8/24.
//  Copyright © 2020 CoderDoraemon. All rights reserved.
//

#import "LDPThreadMutexConditionDemo.h"
#import <pthread.h>

@interface LDPThreadMutexConditionDemo ()

@property (nonatomic, assign) pthread_mutex_t lock;
@property (nonatomic, assign) pthread_cond_t cond;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation LDPThreadMutexConditionDemo

- (void)__initMuteex:(pthread_mutex_t *)mutex {
    
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    
    // 初始化锁 NULL：为默认普通锁
    pthread_mutex_init(mutex, &attr);
    
    // 初始化条件
    pthread_cond_init(&_cond, NULL);
    
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    
    self.data = [NSMutableArray array];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化锁
        [self __initMuteex:&_lock];
        NSConditionLock
    }
    return self;
}

- (void)testCondition {
    [[[NSThread alloc] initWithTarget:self selector:@selector(remove) object:nil] start];
    sleep(2);
    [[[NSThread alloc] initWithTarget:self selector:@selector(add) object:nil] start];
}

- (void)remove {
    pthread_mutex_lock(&_lock);
    if (self.data.count == 0) {
        // 睡眠等待条件被激活
        pthread_cond_wait(&_cond, &_lock);
    }
    [self.data removeLastObject];
    NSLog(@"删除");
    pthread_mutex_unlock(&_lock);
}

- (void)add {
    pthread_mutex_lock(&_lock);
    [self.data addObject:@"test"];
    NSLog(@"添加");
    // 发送信号给条件
    pthread_cond_signal(&_cond);
    pthread_mutex_unlock(&_lock);
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
    pthread_cond_destroy(&_cond);
}

@end
