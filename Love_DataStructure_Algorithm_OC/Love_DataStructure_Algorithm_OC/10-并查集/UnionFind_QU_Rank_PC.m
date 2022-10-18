//
//  UnionFind_QU_Rank_PC.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU_Rank_PC.h"

/*
 * Quick Union - 基于rank的优化, 路径压缩
 * 矮的树嫁接到高的树
 * 路径压缩: 在find时是路径上的所有节点都指向根节点, 从而降低树的高度
 */
@implementation UnionFind_QU_Rank_PC


/// 查找V所属的集合(根节点)
- (int)find:(int)v {
    [self rangeCheck:v];
    
    if ([self.parents[v] intValue] != v) {
        int parent = [self.parents[v] intValue];
        int root   = [self find:parent]; // 递归调用 - 沿着父节点继续往上找 使路径上的所有节点都指向根节点, 从而降低树的高度
        self.parents[v] = [NSNumber numberWithInt:root];
    }
    
    return [self.parents[v] intValue];
}


@end
