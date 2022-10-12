//
//  Queue.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/13.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 队列 -  - 用链表实现
@interface Queue : NSObject

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
