//
//  LDProxy.m
//  LDProxy
//
//  Created by jz on 2020/8/12.
//  Copyright © 2020 jz. All rights reserved.
//

#import "LDProxy.h"

@implementation LDProxy

+ (instancetype)proxyWithTarget:(id)target {
    
    LDProxy *proxy = [LDProxy alloc];
    proxy.target = target;
    return proxy;
}

// 返回方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return  [self.target methodSignatureForSelector:sel];
}
// 直接调用
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self];
}

@end
