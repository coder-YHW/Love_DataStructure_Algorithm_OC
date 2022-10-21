//
//  GenericUnionFind.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "GenericUnionFind.h"
#import "UnionFindNode.h"
#import "HashMap.h"

@implementation GenericUnionFind {
    HashMap *nodeMap;
}
 
#pragma mark - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        nodeMap = [[HashMap alloc] init];
    }
    return self;
}

#pragma mark - 方法
/// 根据val 创建node 加入nodeMap
- (void)makeSet:(id)val {
    
    if ([nodeMap containsKey:val]) { return; }
    UnionFindNode *node = [[UnionFindNode alloc] initWitVal:val];
    [nodeMap put:val value:node];
}

/// 查找V所属的集合(根节点)
- (id)find:(id)val {
    UnionFindNode *node = [self findNode:val];
    return node == nil ? nil : node.value;
}

/// 合并v1, v2所在的集合
- (void)unionVal:(id)val1 val:(id)val2 {
    UnionFindNode *parent1 = [self findNode:val1];
    UnionFindNode *parent2 = [self findNode:val2];
    if (parent1 == nil ||
        parent2 == nil ||
        parent1.value == parent2.value) { // 空 或 同一个集合
        return;
    }
    
    // rank小的合并到rank大的
    if (parent1.rank < parent2.rank) {
        parent1.parent = parent2;
    }else if (parent1.rank > parent2.rank) {
        parent2.parent = parent1;
    }else {
        parent1.parent = parent2;
        parent2.rank += 1;
    }
}

/// 检查v1, v2是否属于同一个集合
- (BOOL)isSame:(id)val1 val:(id)val2 {
    UnionFindNode *parent1 = [self findNode:val1];
    UnionFindNode *parent2 = [self findNode:val2];
    return parent1 == parent2;
}

/// 找出Val的根节点
- (UnionFindNode *)findNode:(id)val {
    
    if (val == nil) { return nil; }
    
    // 1、找到节点
    UnionFindNode *node = [nodeMap get:val];
    if (node == nil) { return nil; }
    
    // 2、找到节点的根节点
    while (node.value != node.parent.value) {
        node.parent = node.parent.parent;
        node = node.parent;
    }
    
    return node;
}

@end
