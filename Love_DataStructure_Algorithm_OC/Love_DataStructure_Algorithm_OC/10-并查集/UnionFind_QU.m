//
//  UnionFind_QU.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU.h"

@implementation UnionFind_QU


#pragma mark - 方法
/// 查找V所属的集合(根节点)
- (int)find:(int)v { // 通过parent链条不断地向上找，直到找到根节点 - 时间复杂度O(logn)
    [self rangeCheck:v];
    
    int val = [self.parents[v] intValue];
     
    while (val != [self.parents[val] intValue]) { // 1、当父节点是自己时 就是根节点
        val = [self.parents[val] intValue]; // 2、// 当父节点不是自己时 通过parent链条不断地向上找
    }
    
    return val;
}

/// 合并v1, v2所在的集合 - 时间复杂度O(nlogn)
- (void)unionVal:(int)v1 val:(int)v2 {
    int parent1 = [self find:v1];
    int parent2 = [self find:v2];
    if (parent1 == parent2) { return; }
    
    // 替换根节点
    self.parents[parent1] = [NSNumber numberWithInt:parent2];
}


@end
