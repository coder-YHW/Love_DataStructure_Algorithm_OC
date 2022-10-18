//
//  UnionFind.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * 并查集
 * 只接受Int
 * 支持泛型的并查集使用: GenericUnionFind
 */
@interface UnionFind : NSObject

#pragma mark - 属性
/// 当前父节点集和
@property (nonatomic,strong) NSMutableArray *parents;


#pragma mark - 构造函数
/** 构造函数 */
- (instancetype)initWithCapaticy:(int)capaticy;


#pragma mark - 方法
/// 查找V所属的集合(根节点)
- (int)find:(int)v;

/// 合并v1, v2所在的集合
- (void)unionVal:(int)v1 val:(int)v2;

/// 检查v1, v2是否属于同一个集合
- (BOOL)isSame:(int)v1 val:(int)v2;

/// 判断是否越界: no越界
- (void)rangeCheck:(int)v;

@end

NS_ASSUME_NONNULL_END
