//
//  ListGraph.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import "Graph.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListGraph : Graph

/// 打印图
- (void)printListGraph;


#pragma mark - AOV网问题 - 拓扑排序（卡恩算法）
- (NSMutableArray *)topologicalSort;

#pragma mark - 最小生成树问题（光缆铺设）- Prim算法
- (HashSet *)mstPrim;
#pragma mark   最小生成树问题（光缆铺设）- Kruskal算法
- (HashSet *)mstKruskal;

@end

NS_ASSUME_NONNULL_END
