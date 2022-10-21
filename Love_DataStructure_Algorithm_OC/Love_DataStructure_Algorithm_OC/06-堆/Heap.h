//
//  Heap.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heap : NSObject

/** 元素的数量 */
- (int)size;

/** 是否为空 */
- (bool)isEmpty;

/** 清空 */
- (void)clear;

/** 添加元素 */
- (void)add:(id)element;

/** 获得堆顶元素 */
- (id)getTop;

/** 出堆 - 删除堆顶元素 */
- (id)remove;

/** 删除堆顶元素的同时插入一个新元素 */
- (id)replace:(id)element;

@end

NS_ASSUME_NONNULL_END
