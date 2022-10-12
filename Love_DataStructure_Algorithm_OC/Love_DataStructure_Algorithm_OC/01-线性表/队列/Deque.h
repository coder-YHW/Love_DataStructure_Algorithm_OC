//
//  Deque.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/14.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 双端队列  - 用链表实现
@interface Deque : NSObject

/** 元素的数量 */
- (int)size;

/** 是否为空 */
- (BOOL)isEmpty;

/** 清空 */
- (void)clear;

/** 从前面入队  - 扩展*/
- (void)enQueueFront:(id)element;

/** 从后面入队 */
- (void)enQueueRear:(id)element;

/** 从前面出队 */
- (id)deQueueFront;

/** 从后面出队  - 扩展*/
- (id)deQueueRear;

/**获取队列的头元素 */
- (id)front;

/** 获取队列的尾元素 */
- (id)rear;

@end

NS_ASSUME_NONNULL_END
