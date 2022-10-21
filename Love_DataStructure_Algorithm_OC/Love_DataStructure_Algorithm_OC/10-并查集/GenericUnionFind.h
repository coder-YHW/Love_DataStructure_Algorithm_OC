//
//  GenericUnionFind.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 泛型并查集
@interface GenericUnionFind : NSObject

#pragma mark - 方法

/// 根据val 创建node 加入nodeMap
- (void)makeSet:(id)val;

/// 查找V所属的集合(根节点)
- (id)find:(id)val;

/// 合并v1, v2所在的集合
- (void)unionVal:(id)val1 val:(id)val2;

/// 检查v1, v2是否属于同一个集合
- (BOOL)isSame:(id)val1 val:(id)val2;

@end

NS_ASSUME_NONNULL_END
