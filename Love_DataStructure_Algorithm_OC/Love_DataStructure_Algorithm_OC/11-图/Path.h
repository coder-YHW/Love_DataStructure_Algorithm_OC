//
//  Path.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import <Foundation/Foundation.h>
#import "Edge.h"

NS_ASSUME_NONNULL_BEGIN
/// 路径
@interface Path : NSObject

#pragma mark - 属性

/// weight - 权重
@property (nonatomic,assign) double weight;

/// 路径上所有的边, 存储的有顺序的边
@property (nonatomic,strong) NSMutableArray<Edge *> *edgeInfos;


#pragma mark - 方法
/// 添加边
- (void)addEdge:(Edge *)edge;

@end

NS_ASSUME_NONNULL_END
