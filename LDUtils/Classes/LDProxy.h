//
//  LDProxy.h
//  LDProxy
//
//  Created by jz on 2020/8/12.
//  Copyright © 2020 jz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDProxy : NSProxy

@property (nonatomic, weak) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
