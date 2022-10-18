//
//  UnionFind_QU_Size.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind_QU_Size.h"

@interface UnionFind_QU_Size ()

#pragma mark - 属性
/// 存储集合的元素个数
@property (nonatomic,strong) NSMutableArray *sizeArr;

@end

@implementation UnionFind_QU_Size

#pragma mark - 构造函数
/** 构造函数 */
- (instancetype)initWithCapaticy:(int)capaticy {
    
    self.sizeArr = [NSMutableArray arrayWithCapacity:capaticy];
    for (int i = 0 ; i < self.sizeArr.count ; i++) {
        self.sizeArr[i] = [NSNumber numberWithInt:1];
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
    int size1 = [self.sizeArr[v1] intValue];
    int size2 = [self.sizeArr[v2] intValue];
    
    // 节点少的合并到节点多的
    if (size1 < size2) {
        self.parents[parent1] = [NSNumber numberWithInt:parent2];
        parent2 = parent1 + parent2;
        self.sizeArr[parent2] = [NSNumber numberWithInt:parent2];
    }else {
        self.parents[parent2] = [NSNumber numberWithInt:parent1];
        
        parent1 = parent1 + parent2;
        self.sizeArr[parent1] = [NSNumber numberWithInt:parent1];  // 更新size
    }
    
}


@end
