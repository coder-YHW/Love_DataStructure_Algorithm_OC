//
//  UnionFind_QU_Rank_PS.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU_Rank_PS.h"

/*
 * Quick Union - 基于rank的优化, 路径分裂
 * 矮的树嫁接到高的树
 * 路径分裂: 使路径上的每个节点都指向其祖父节点
 */
@implementation UnionFind_QU_Rank_PS


/// 查找V所属的集合(根节点)
- (int)find:(int)v {
    [self rangeCheck:v];
    
    int val = v;
    if ([self.parents[val] intValue] != val) {
        
        int parent = [self.parents[val] intValue];
        int grand  = [self.parents[parent] intValue];
        self.parents[val] = [NSNumber numberWithInt:grand];
        
        val = parent; // 沿着父节点继续往上找 - 使路径上的每个节点都指向其祖父节点
    }
    
    return val;
}



@end
