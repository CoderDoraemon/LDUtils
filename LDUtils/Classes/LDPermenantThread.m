//
//  LDPermenantThread.m
//  LDUtils
//
//  Created by jz on 2020/8/19.
//

#import "LDPermenantThread.h"
#import "LDProxy.h"

@interface LDThread : NSThread
@end

@implementation LDThread

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

@interface LDPermenantThread ()

@property (strong, nonatomic) LDThread *thread;


@property (assign, nonatomic, getter=isStopThread) BOOL stopThread;

@end

@implementation LDPermenantThread

- (instancetype)init {
    if (self = [super init]) {
        self.stopThread = NO;
        
        if (@available(iOS 10.0, *)) {
            __weak typeof(self) weakSelf = self;
            self.thread = [[LDThread alloc] initWithBlock:^{
//                [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//
//                while (weakSelf && !weakSelf.isStopThread) {
//                    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//                }
                
                // C语言
                // 创建上下文，初始化数据
                CFRunLoopSourceContext context = {0};
                // 创建source
                CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
                // runloop添加source
                CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
                CFRelease(source);
                
                CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1E30, false);
                
//                while (weakSelf && !weakSelf.isStopThread) {
//                    // 启动runloop
//                    // returnAfterSourceHandled 第三个参数为true，代表执行完source退出当前runloop
//                    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1E30, true);
//                }
                
            }];
        } else {
            
            self.thread = [[LDThread alloc] initWithTarget:self selector:@selector(doRunLoop) object:nil];
        }
    }
    return self;
}

- (void)doRunLoop {
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    
    while (self && !self.isStopThread) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)__stop {
    self.stopThread = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__doTask:(LDPermenantThreadTask)task {
     task();
}


- (void)run {
    if (!self.thread) return;
    [self.thread start];
}

- (void)excelTask:(LDPermenantThreadTask)task {
    if (!self.thread || !task) return;
    
    if (!self.thread.isExecuting) {
        [self.thread start];
    }
    
    [self performSelector:@selector(__doTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!self.thread) return;
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)dealloc {
    [self stop];
}

@end
