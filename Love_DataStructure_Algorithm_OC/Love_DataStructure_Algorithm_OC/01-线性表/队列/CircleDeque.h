//
//  CircleDeque.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/14.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 循环双端队列  - 用优化后的动态数组实现
@interface CircleDeque : NSObject

#pragma mark - 方法
/** 元素的数量 */
- (int)size;

/** 是否为空 */
- (BOOL)isEmpty;

/** 清空 */
- (void)clear;

/** 从后面入队 */
- (void)enQueueRear:(id)element;

/** 从后面出队 */
- (id)deQueueRear;

/// 从头部入队
- (void)enQueueFront:(id)element;

/// 从头部出队
- (id)deQueueFront;

/**获取队列的头元素 */
- (id)front;

/** 获取队列的尾元素 */
- (id)rear;

@end

NS_ASSUME_NONNULL_END
