//
//  LDPermenantThread.h
//  LDUtils
//
//  Created by jz on 2020/8/19.
//
//  自定义线程中处理事务

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LDPermenantThreadTask)(void);

@interface LDPermenantThread : NSObject

/**
 开启线程
 */
- (void)run;

/**
 线程中执行任务
 */
- (void)excelTask:(LDPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
