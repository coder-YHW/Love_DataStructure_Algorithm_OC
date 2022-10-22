//
//  GraphTest.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/20.
//

#import "GraphTest.h"

@implementation GraphTest


#pragma mark - AOV网问题 - 拓扑排序（卡恩算法）
+ (void)testTopologicalSort {
    
    NSArray *TOPO = @[
            @[@0, @2],
            @[@1, @0],
            @[@2, @5], @[@2, @6],
            @[@3, @1], @[@3, @5], @[@3, @7],
            @[@5, @7],
            @[@6, @4],
            @[@7, @6]
    ];

    ListGraph *graph = [[ListGraph alloc] init];
    for (NSArray *arr in TOPO) { // 有向图
        [graph addEdgeFrom:arr[0] to:arr[1]];
    }
    NSMutableArray *array = [graph topologicalSort];
    NSLog(@"%@", array);
}


#pragma mark - 最小生成树问题（光缆铺设）- Prim算法
+ (void)testMstPrim {
    
    NSArray *MST_01 = @[
                @[@0, @2, @2], @[@0, @4, @7],
                @[@1, @2, @3], @[@1, @5, @1], @[@1, @6, @7],
                @[@2, @4, @4], @[@2, @5, @3], @[@2, @6, @6],
                @[@3, @7, @9],
                @[@4, @6, @8],
                @[@5, @6, @4], @[@5, @7, @5]
   ];

    ListGraph *graph = [[ListGraph alloc] init];
    for (NSArray *arr in MST_01) { // 无向图
        [graph addEdgeFrom:arr[0] to:arr[1] weight:[arr[2] doubleValue]];
        [graph addEdgeFrom:arr[1] to:arr[0] weight:[arr[2] doubleValue]];
    }

    HashSet *set = [graph mstPrim]; // Prim算法
    [set traversalWithBlock:^(id  _Nonnull element) {
        NSLog(@"%@", element);
    }];
}


#pragma mark   最小生成树问题（光缆铺设）- Kruskal算法
+ (void)testMstKruskal {
    
    NSArray *MST_01 = @[
                @[@0, @2, @2], @[@0, @4, @7],
                @[@1, @2, @3], @[@1, @5, @1], @[@1, @6, @7],
                @[@2, @4, @4], @[@2, @5, @3], @[@2, @6, @6],
                @[@3, @7, @9],
                @[@4, @6, @8],
                @[@5, @6, @4], @[@5, @7, @5]
   ];

    ListGraph *graph = [[ListGraph alloc] init];
    for (NSArray *arr in MST_01) { // 无向图
        [graph addEdgeFrom:arr[0] to:arr[1] weight:[arr[2] doubleValue]];
        [graph addEdgeFrom:arr[1] to:arr[0] weight:[arr[2] doubleValue]];
    }

    HashSet *set = [graph mstKruskal]; // Kruskal算法
    [set traversalWithBlock:^(id  _Nonnull element) {
        NSLog(@"%@", element);
    }];
}


#pragma mark - 最短路径问题 - 简单版 (拽石头-松弛操作）
+ (void)testShortestPath {
    
    NSArray *SP = @[
            @[@"A", @"B", @10], @[@"A", @"D", @30], @[@"A", @"E", @100],
            @[@"B", @"C", @50],
            @[@"C", @"E", @10],
            @[@"D", @"C", @20], @[@"D", @"E", @60]
    ];

    ListGraph *graph = [[ListGraph alloc] init];
    for (NSArray *arr in SP) { // 无向图
        [graph addEdgeFrom:arr[0] to:arr[1] weight:[arr[2] doubleValue]];
        [graph addEdgeFrom:arr[1] to:arr[0] weight:[arr[2] doubleValue]];
    }

    HashMap *map = [graph shortestPath:@"A"]; // Kruskal算法
    [map traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
        NSLog(@"A->%@--%@",key,value);
    }];
}


#pragma mark   单源最短路径算法1 - Dijkstra(迪杰斯特拉)
+ (void)testDijkstraShortPath {
    
    NSArray *SP = @[
            @[@"A", @"B", @10], @[@"A", @"D", @30], @[@"A", @"E", @100],
            @[@"B", @"C", @50],
            @[@"C", @"E", @10],
            @[@"D", @"C", @20], @[@"D", @"E", @60]
    ];

    ListGraph *graph = [[ListGraph alloc] init];
    for (NSArray *arr in SP) { // 无向图
        [graph addEdgeFrom:arr[0] to:arr[1] weight:[arr[2] doubleValue]];
        [graph addEdgeFrom:arr[1] to:arr[0] weight:[arr[2] doubleValue]];
    }

    HashMap *map = [graph dijkstraShortPath:@"A"]; // Kruskal算法
    [map traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
        NSLog(@"A->%@--%@",key,value);
    }];
}


#pragma mark   单源最短路径算法2 - BellmanFord(贝尔曼-福特)
+ (void)testBellmanFordShortPath {
    
    NSArray *SP = @[
            @[@"A", @"B", @10], @[@"A", @"D", @30], @[@"A", @"E", @100],
            @[@"B", @"C", @50],
            @[@"C", @"E", @10],
            @[@"D", @"C", @20], @[@"D", @"E", @60]
    ];

    ListGraph *graph = [[ListGraph alloc] init];
    for (NSArray *arr in SP) { // 无向图
        [graph addEdgeFrom:arr[0] to:arr[1] weight:[arr[2] doubleValue]];
//        [graph addEdgeFrom:arr[1] to:arr[0] weight:[arr[2] doubleValue]];
    }

    HashMap *map = [graph bellmanFordShortPath:@"A"]; // Kruskal算法
    [map traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
        NSLog(@"A->%@--%@",key,value);
    }];
}


#pragma mark   多源最短路径算法 floydShortPath（弗洛伊德）
/// 测试最短路径问题3 - floyd算法
+ (void)testFloydShortPath {
    
    NSArray *SP = @[
            @[@"A", @"B", @10], @[@"A", @"D", @30], @[@"A", @"E", @100],
            @[@"B", @"C", @50],
            @[@"C", @"E", @10],
            @[@"D", @"C", @20], @[@"D", @"E", @60]
    ];

    ListGraph *graph = [[ListGraph alloc] init];
    for (NSArray *arr in SP) { // 有向图
        [graph addEdgeFrom:arr[0] to:arr[1] weight:[arr[2] doubleValue]];
//        [graph addEdgeFrom:arr[1] to:arr[0] weight:[arr[2] doubleValue]];
    }

    HashMap *map = [graph floydShortPath]; //
    [map traversalWithBlock:^(id  _Nonnull key1, id  _Nonnull value1) {
        NSLog(@"------------%@---------------",key1);
        HashMap *map1 = (HashMap *)value1;
        [map1 traversalWithBlock:^(id  _Nonnull key2, id  _Nonnull value2) {
            NSLog(@"from:%@ -> to:%@ -- %@", key1, key2, value2);
        }];

    }];
}

@end
