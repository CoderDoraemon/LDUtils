//
//  LDBaseDemo.h
//  LDUtils_Example
//
//  Created by jz on 2020/8/22.
//  Copyright © 2020 CoderDoraemon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDBaseDemo : NSObject

/** 测试取票 */
- (void)testTicket;
/** 测试存钱取钱 */
- (void)testMoney;

/** 存钱 */
- (void)saveMoney;
/** 取钱 */
- (void)drawMoney;
/** 卖票 */
- (void)sellTicket;

@end

NS_ASSUME_NONNULL_END
