//
//  Graph.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
/// /// 图 - 接口设计
@interface Graph : NSObject

/// 顶点个数
- (int)vertexsSize;

/// 边的个数
- (int)edgesSize:(id)val;

/// 添加顶点
- (void)addVertexVal:(id)val;

/// 添加边
- (void)addEdgeFrom:(id)from to:(id)to;

/// 添加边(带权重)
- (void)addEdgeFrom:(id)from to:(id)to weight:(double)weight;

/// 删除顶点
- (void)removeVertexVal:(id)val;

/// 删除边
- (void)removeEdgeFrom:(id)from to:(id)to;

@end

NS_ASSUME_NONNULL_END
