//
//  StackQueue.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/13.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 用2个栈实现队列操作 （inStack➕outStack）
@interface StackQueue : NSObject

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
