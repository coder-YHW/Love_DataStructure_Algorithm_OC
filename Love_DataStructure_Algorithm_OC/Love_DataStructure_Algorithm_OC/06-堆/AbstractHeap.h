//
//  AbstractHeap.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "Heap.h"

/** 实现打印二叉树：
 * 1、遵守MJBinaryTreeInfo协议
 * 2、实现MJBinaryTreeInfo协议方法
*/
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface AbstractHeap : Heap <MJBinaryTreeInfo>

/** int */
@property (nonatomic,assign) int size;

@end

NS_ASSUME_NONNULL_END
