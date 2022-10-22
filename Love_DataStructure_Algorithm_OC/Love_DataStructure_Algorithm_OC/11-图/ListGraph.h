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


#pragma mark - 最短路径问题 - 简单版 (拽石头-松弛操作）
- (HashMap *)shortestPath:(id)begin;
#pragma mark   单源最短路径算法1 - Dijkstra(迪杰斯特拉)
- (HashMap *)dijkstraShortPath:(id)begin;
#pragma mark   单源最短路径算法2 - BellmanFord(贝尔曼-福特)
- (HashMap *)bellmanFordShortPath;
#pragma mark   多源最短路径算法 floydShortPath（弗洛伊德）
- (HashMap *)floydShortPath;

@end

NS_ASSUME_NONNULL_END
