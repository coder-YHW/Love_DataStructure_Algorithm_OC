//
//  CircleQueue.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/14.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 循环队列 - 用优化后的动态数组实现
@interface CircleQueue : NSObject

#pragma mark - 方法
/** 元素的数量 */
- (int)size;

/** 是否为空 */
- (BOOL)isEmpty;

/** 清空 */
- (void)clear;

/** 入队 */
- (void)enQueue:(id)element;

/** 出队 */
- (id)deQueue;

/**获取队列的头元素 */
- (id)front;

@end

NS_ASSUME_NONNULL_END
