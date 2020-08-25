//
//  LDOSUnfairLockDemo.m
//  LDUtils_Example
//
//  Created by jz on 2020/8/22.
//  Copyright © 2020 CoderDoraemon. All rights reserved.
//

#import "LDOSUnfairLockDemo.h"
#import <os/lock.h>

@interface LDOSUnfairLockDemo ()

@property (nonatomic, assign) os_unfair_lock moneyLock;
@property (nonatomic, assign) os_unfair_lock ticketLock;

@end

@implementation LDOSUnfairLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_UNFAIR_LOCK_INIT;
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)saveMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super saveMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)drawMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super drawMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)sellTicket {
    os_unfair_lock_lock(&_ticketLock);
    [super sellTicket];
    os_unfair_lock_unlock(&_ticketLock);
}

@end
