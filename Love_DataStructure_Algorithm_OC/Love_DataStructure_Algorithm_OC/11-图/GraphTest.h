//
//  GraphTest.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 图 - 测试用例
@interface GraphTest : NSObject


#pragma mark - AOV网问题 - 拓扑排序（卡恩算法）
+ (void)testTopologicalSort;


#pragma mark - 最小生成树问题（光缆铺设）- Prim算法
+ (void)testMstPrim;
#pragma mark   最小生成树问题（光缆铺设）- Kruskal算法
+ (void)testMstKruskal;


#pragma mark - 最短路径问题 - 简单版 (拽石头-松弛操作）
+ (void)testShortestPath;
#pragma mark   单源最短路径算法1 - Dijkstra(迪杰斯特拉)
+ (void)testDijkstraShortPath;
#pragma mark   单源最短路径算法2 - BellmanFord(贝尔曼-福特)
+ (void)testBellmanFordShortPath;
#pragma mark   多源最短路径算法 floydShortPath（弗洛伊德）
/// 测试最短路径问题3 - floyd算法
+ (void)testFloydShortPath;

@end

NS_ASSUME_NONNULL_END
