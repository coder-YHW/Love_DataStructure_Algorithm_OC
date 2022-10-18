//
//  UnionFind_QU_Rank_PH.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU_Rank.h"

NS_ASSUME_NONNULL_BEGIN

/*
 * Quick Union - 基于rank的优化, 路径减半
 * 矮的树嫁接到高的树
 * 路径减半: 使路径上每隔一个节点就指向其祖父节点
 */
@interface UnionFind_QU_Rank_PH : UnionFind_QU_Rank

@end

NS_ASSUME_NONNULL_END
