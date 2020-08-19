//
//  LDSecondViewController.m
//  LDUtils_Example
//
//  Created by jz on 2020/8/19.
//  Copyright © 2020 CoderDoraemon. All rights reserved.
//

#import "LDSecondViewController.h"
#import <LDUtils/LDUtils.h>


@interface LDSecondViewController ()

@property (nonatomic, strong) LDPermenantThread *pmt;

@end

@implementation LDSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pmt = [[LDPermenantThread alloc] init];
//    [self.pmt run];
}

- (IBAction)stop {
    [self.pmt stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.pmt excelTask:^{
        NSLog(@"执行任务--%@", [NSThread currentThread]);
    }];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
