//
//  LDPThreadMutexDemo.m
//  LDUtils_Example
//
//  Created by jz on 2020/8/22.
//  Copyright © 2020 CoderDoraemon. All rights reserved.
//

#import "LDPThreadMutexDemo.h"
#import <pthread.h>

@interface LDPThreadMutexDemo ()

@property (nonatomic, assign) pthread_mutex_t moneyLock;
@property (nonatomic, assign) pthread_mutex_t ticketLock;

@end

@implementation LDPThreadMutexDemo

- (void)__initMuteex:(pthread_mutex_t *)mutex {
    
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
//    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);

    
    /**
     Mutex type attributes
     
     #define PTHREAD_MUTEX_NORMAL        0 // 普通锁
     #define PTHREAD_MUTEX_ERRORCHECK    1 // 错误检测锁
     #define PTHREAD_MUTEX_RECURSIVE        2 递归锁
     */
    
    // 初始化锁 NULL：为默认普通锁
//    pthread_mutex_init(mutex, NULL);
    pthread_mutex_init(mutex, &attr);
    
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 静态初始化
//        pthread_mutex_t moneyLock = PTHREAD_MUTEX_INITIALIZER;
//        pthread_mutex_t ticketLock = PTHREAD_MUTEX_INITIALIZER;
        
        // 初始化锁
        [self __initMuteex:&_moneyLock];
        [self __initMuteex:&_ticketLock];
    }
    return self;
}

- (void)saveMoney {
    pthread_mutex_lock(&_moneyLock);
    [super saveMoney];
    pthread_mutex_unlock(&_moneyLock);
}

- (void)drawMoney {
    pthread_mutex_lock(&_moneyLock);
    [super drawMoney];
    pthread_mutex_unlock(&_moneyLock);
}

- (void)sellTicket {
    pthread_mutex_lock(&_ticketLock);
    [super sellTicket];
    pthread_mutex_unlock(&_ticketLock);
}

- (void)dealloc {
    pthread_mutex_destroy(&_moneyLock);
    pthread_mutex_destroy(&_ticketLock);
}

@end
