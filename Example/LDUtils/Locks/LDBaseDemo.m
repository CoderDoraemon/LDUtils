//
//  LDBaseDemo.m
//  LDUtils_Example
//
//  Created by jz on 2020/8/22.
//  Copyright © 2020 CoderDoraemon. All rights reserved.
//

#import "LDBaseDemo.h"

@interface LDBaseDemo ()

@property (nonatomic, assign) int money;
@property (nonatomic, assign) int ticketCount;

@end

@implementation LDBaseDemo

- (void)testTicket {
    
    self.ticketCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self sellTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self sellTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self sellTicket];
        }
    });
}

- (void)testMoney {
    self.money = 100;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self drawMoney];
        }
    });
}

- (void)saveMoney {
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    NSLog(@"存20，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

- (void)drawMoney {
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    NSLog(@"取20，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

- (void)sellTicket {
    int oldTicketCount = self.ticketCount;
    sleep(.2);
    oldTicketCount--;
    self.ticketCount = oldTicketCount;
    NSLog(@"还剩%d张票 - %@", oldTicketCount, [NSThread currentThread]);
}

@end
