//
//  UnionFind_QU_Rank_PC.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU_Rank.h"

NS_ASSUME_NONNULL_BEGIN

/*
 * Quick Union - 基于rank的优化, 路径压缩
 * 矮的树嫁接到高的树
 * 路径压缩: 在find时是路径上的所有节点都指向根节点, 从而降低树的高度
 */
@interface UnionFind_QU_Rank_PC : UnionFind_QU_Rank

@end

NS_ASSUME_NONNULL_END
