//
//  TreeMap.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "Map.h"
#import "MapNode.h"

/** 实现打印二叉树：
 * 1、遵守MJBinaryTreeInfo协议
 * 2、实现MJBinaryTreeInfo协议方法
*/
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 比较器-接口设计
// 1、协议 - 协议
@protocol MJMapComparator
@required
- (int)compare:(id)e1 another:(id)e2;
@end

// 2、Block - 比较器
typedef int (^MJMapComparatorBlock)(id e1, id e2);

@interface TreeMap : Map <MJBinaryTreeInfo>

/** 构造函数 */
+ (instancetype)map;
+ (instancetype)mapWithComparatorBlock:(_Nullable MJMapComparatorBlock)comparator;
+ (instancetype)mapWithComparator:(_Nullable id<MJMapComparator>)comparator;


@end

NS_ASSUME_NONNULL_END
