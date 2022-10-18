//
//  UnionFind_QU_Rank.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU_Rank.h"

/*
 * Quick Union - 基于rank的优化
 * 矮的树嫁接到高的树
 */
@interface UnionFind_QU_Rank ()

#pragma mark - 属性
/// 存储集合的树的高度
@property (nonatomic,strong) NSMutableArray *rankArr;

@end

@implementation UnionFind_QU_Rank

#pragma mark - 构造函数
/** 构造函数 */
- (instancetype)initWithCapaticy:(int)capaticy {
    
    self.rankArr = [NSMutableArray arrayWithCapacity:capaticy];
    for (int i = 0 ; i < self.rankArr.count ; i++) {
        self.rankArr[i] = [NSNumber numberWithInt:1];
    }
    
    return [super initWithCapaticy:capaticy];
}


#pragma mark - 合并v1, v2所在的集合
/// 合并v1, v2所在的集合
- (void)unionVal:(int)v1 val:(int)v2 {
    int parent1 = [self find:v1];
    int parent2 = [self find:v2];
    if (parent1 == parent2) { return; }
    
    // 替换根节点
    int rank1 = [self.rankArr[v1] intValue];
    int rank2 = [self.rankArr[v2] intValue];
    
    // 矮的树嫁接到高的树
    if (rank1 < rank2) {
        self.parents[parent1] = [NSNumber numberWithInt:parent2];
    }else if (rank1 > rank2) {
        self.parents[parent2] = [NSNumber numberWithInt:parent1];
    }else { // rank1 = rank2
        self.parents[parent1] = [NSNumber numberWithInt:parent2]; // 2种都可以
        
        rank2 = rank2 + 1;
        self.rankArr[parent2] = [NSNumber numberWithInt:rank2];  // 更新rank
    }
    
}

@end
