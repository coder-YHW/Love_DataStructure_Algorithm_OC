//
//  BinaryHeap.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "AbstractHeap.h"

NS_ASSUME_NONNULL_BEGIN

/**堆类型*/
typedef NS_ENUM(NSInteger, HeapType) {
    HeapTypeBig       = 0,  // 0：大顶堆、 - 默认
    HeapTypeSmall     = 1,  // 1：小顶堆、
};

#pragma mark - 比较器-接口设计
// 1、协议 - 协议
@protocol MJHeapComparator
@required
- (int)compare:(id)e1 another:(id)e2;
@end

// 2、Block - 比较器
typedef int (^MJHeapComparatorBlock)(id e1, id e2);

/// 二叉堆（最大堆）-（完全二叉树、完全二叉堆） 通过索引index拿到左右子树、父节点来操作完全二叉树
@interface BinaryHeap : AbstractHeap

/** 构造函数 */
+ (instancetype)heap;
+ (instancetype)heapWithComparatorBlock:(_Nullable MJHeapComparatorBlock)comparator;
+ (instancetype)heapWithComparator:(_Nullable id<MJHeapComparator>)comparator;

@property (nonatomic,assign) HeapType heapType; // 0：大顶堆  1：小顶堆

@end

NS_ASSUME_NONNULL_END
