//
//  UnionFind_QF.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QF.h"

@implementation UnionFind_QF


#pragma mark - 方法
/// 查找V所属的集合(根节点) - 时间复杂度O(1)
- (int)find:(int)v {
    [self rangeCheck:v];
    return [self.parents[v] intValue];
}

/// 合并v1, v2所在的集合  - 时间复杂度O(n)
- (void)unionVal:(int)v1 val:(int)v2 {
    int parent1 = [self find:v1];
    int parent2 = [self find:v2];
    if (parent1 == parent2) { return; }
    
    for (int i = 0 ; i < self.parents.count ; i++) {
        int parent = [self.parents[i] intValue];
        if (parent == parent1) { // 替换父节点
            self.parents[i] = [NSNumber numberWithInt:parent2];
        }
    }
}


@end
