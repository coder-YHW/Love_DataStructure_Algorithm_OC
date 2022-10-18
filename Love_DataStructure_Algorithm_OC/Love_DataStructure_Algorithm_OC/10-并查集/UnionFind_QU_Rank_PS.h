//
//  UnionFind_QU_Rank_PS.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU_Rank.h"

NS_ASSUME_NONNULL_BEGIN

/*
 * Quick Union - 基于rank的优化, 路径分裂
 * 矮的树嫁接到高的树
 * 路径分裂: 使路径上的每个节点都指向其祖父节点
 */
@interface UnionFind_QU_Rank_PS : UnionFind_QU_Rank

@end

NS_ASSUME_NONNULL_END
