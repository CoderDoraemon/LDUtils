//
//  LDViewController.m
//  LDUtils
//
//  Created by CoderDoraemon on 08/19/2020.
//  Copyright (c) 2020 CoderDoraemon. All rights reserved.
//

#import "LDViewController.h"
#import <LDUtils/LDUtils.h>
#import "LDBaseDemo.h"
#import "LDOSSpinLockDemo.h"
#import "LDOSUnfairLockDemo.h"
#import "LDPThreadMutexDemo.h"
#import "LDPThreadMutexConditionDemo.h"

@interface LDViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (copy, nonatomic) NSString *timerName;

@property (assign, nonatomic) NSInteger number;

@property (strong, nonatomic) LDPermenantThread *thread;

@end

@implementation LDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LDPThreadMutexConditionDemo *demo = [[LDPThreadMutexConditionDemo alloc] init];
    [demo testCondition];
}

- (IBAction)startTimer {
    
    [self cancelTimer];
    
    NSString *timerName = [LDTimer executeTask:^{
        self.number++;
        self.tipLabel.text = [NSString stringWithFormat:@"%ld", (long)self.number];
    } start:0 interval:1 repeats:YES async:NO];
    
    self.timerName = timerName;
}


- (IBAction)cancelTimer {
    
    [LDTimer cancelTask:self.timerName];
    self.tipLabel.text = nil;
    self.number = 0;
}


@end
