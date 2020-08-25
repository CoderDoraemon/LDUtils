//
//  LDOSSpinLockDemo.m
//  LDUtils_Example
//
//  Created by jz on 2020/8/22.
//  Copyright © 2020 CoderDoraemon. All rights reserved.
//

#import "LDOSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface LDOSSpinLockDemo ()

@property (nonatomic, assign) OSSpinLock moneyLock;
@property (nonatomic, assign) OSSpinLock ticketLock;

@end

@implementation LDOSSpinLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_SPINLOCK_INIT;
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)saveMoney {
    OSSpinLockLock(&_moneyLock);
    [super saveMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)drawMoney {
    OSSpinLockLock(&_moneyLock);
    [super drawMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)sellTicket {
    
//    if (OSSpinLockTry(&_ticketLock)) {
//        [super sellTicket];
//        OSSpinLockUnlock(&_ticketLock);
//    }
    
    OSSpinLockLock(&_ticketLock);
    [super sellTicket];
    OSSpinLockUnlock(&_ticketLock);
}

@end
