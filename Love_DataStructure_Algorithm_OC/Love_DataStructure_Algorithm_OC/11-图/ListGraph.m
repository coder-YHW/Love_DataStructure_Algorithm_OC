//
//  ListGraph.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import "ListGraph.h"
#import "Vertex.h"
#import "Edge.h"
#import "Path.h"

#import "Queue.h"
#import "Stack.h"
#import "HashMap.h"
#import "HashSet.h"


@interface ListGraph ()

#pragma mark - 属性
/** 顶点 - HashMap */
@property (nonatomic,strong) HashMap  *vertexs;
/** 边 - HashSet */
@property (nonatomic,strong) HashSet  *edges;

@end

@implementation ListGraph

#pragma mark - 构造函数
- (instancetype)init{
    self = [super init];
    if (self) {
        self.vertexs = [[HashMap alloc] init];
        self.edges = [[HashSet alloc] init];
    }
    return self;
}

#pragma mark - override
/// 顶点个数
- (int)vertexsSize {
    return self.vertexs.size;
}

/// 边的个数
- (int)edgesSize:(id)val {
    return self.edges.size;
}

#pragma mark  添加删除
/// 添加顶点
- (void)addVertexVal:(id)val {
    if ([self.vertexs containsKey:val]) { return; }
    
    Vertex *vertex = [[Vertex alloc] initVertexWithVal:val];
    [self.vertexs put:val value:vertex];
}

/// 添加边
- (void)addEdgeFrom:(id)from to:(id)to {
    [self addEdgeFrom:from to:to weight:0];
}

/// 添加边(带权重)
- (void)addEdgeFrom:(id)from to:(id)to weight:(double)weight {
    
    // 1、fromVertex是否存在
    Vertex *fromVertex = [self.vertexs get:from];
    if (!fromVertex) {
        fromVertex = [[Vertex alloc] initVertexWithVal:from];
        [self.vertexs put:from value:fromVertex];
    }
    
    // 2、toVertex是否存在
    Vertex *toVertex = [self.vertexs get:to];
    if (!toVertex) {
        toVertex = [[Vertex alloc] initVertexWithVal:to];
        [self.vertexs put:to value:toVertex];
    }
    
    // 3、Edge是否存在
    Edge *edge = [[Edge alloc] initEdgeFrom:fromVertex to:toVertex];
    edge.weight = weight;
    
    // 3.1 Edge存在 先删除旧edge 再添加新edge - 3个HashSet
    if ([fromVertex.outEdges contains:edge]) { // 注意：此处要重写Edge的isEqual ➕ hash方法
        [fromVertex.outEdges remove:edge];
        [toVertex.inEdges remove:edge];
        [self.edges remove:edge];
    }
    
    // 3.2 添加新edge - 3个HashSet
    [fromVertex.outEdges add:edge];
    [toVertex.inEdges add:edge];
    [self.edges add:edge];
}

/// 删除顶点
- (void)removeVertexVal:(id)val {
    
    // 0、顶点不存在
    Vertex *vertex = [self.vertexs get:val];
    if (vertex == nil) { return; }
    
    // 1、删除inEdges - 不能一边遍历的同时又删除元素，可以用enumerate
    NSMutableArray *inEdgesArray = vertex.inEdges.allElement;
    [inEdgesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Edge *edge = (Edge *)obj;
        
        *stop = YES;
        [self removeEdgeFrom:edge.from.value to:edge.to.value];
        *stop = NO;
    }];
    
    // 2、删除outEdges - 不能一边遍历的同时又删除元素，可以用enumerate
    NSMutableArray *outEdgesArray = vertex.outEdges.allElement;
    [outEdgesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Edge *edge = (Edge *)obj;
        
        *stop = YES;
        [self removeEdgeFrom:edge.from.value to:edge.to.value];
        *stop = NO;
    }];
}

/// 删除边
- (void)removeEdgeFrom:(id)from to:(id)to {
    // 1、fromVertex是否存在
    Vertex *fromVertex = [self.vertexs get:from];
    if (!fromVertex) {
        return;
    }
    
    // 2、toVertex是否存在
    Vertex *toVertex = [self.vertexs get:to];
    if (!toVertex) {
        return;
    }
    
    // 3、Edge是否存在
    Edge *edge = [[Edge alloc] initEdgeFrom:fromVertex to:toVertex];
    
    // 3.1 Edge存在 才删除
    if ([fromVertex.outEdges contains:edge]) { // 注意：此处要重写Edge的isEqual ➕ hash方法
        [fromVertex.outEdges remove:edge];
        [toVertex.inEdges remove:edge];
        [self.edges remove:edge];
    }
}


#pragma mark - 图的遍历 - BFS - 层序遍历-队列实现
- (void)breadthFirstSearch:(id)begin block:(MJGraphTraversalBlock)block {
    // 0、非空检测
    Vertex *vertex = [self.vertexs get:begin];
    if (vertex == nil) { return; }
    
    // 1.1、创建一个hashSet 保存已经遍历过的顶点
    HashSet *set = [[HashSet alloc] init];
    // 1.2、创建一个Queue beginVertex入队
    Queue *queue = [[Queue alloc] init];
    [queue enQueue:vertex];
    [set add:vertex]; // 注意：这句代码位置
    
    while (!queue.isEmpty) {
        
        // 2、出队
        Vertex *vertex = [queue deQueue];
//        NSLog(@"%@", vertex);
        // 遍历器
        if (block) {
            block(vertex.value);
        }
        
        // 3、遍历inEdges 将边.to中 所有非重复顶点入队
        [vertex.outEdges traversalWithBlock:^(id  _Nonnull element) {
            Edge *edge =  (Edge *)element;
            Vertex *vertex = edge.to;
            
            if (![set contains:vertex]) { // 非重复顶点入队
                [queue enQueue:vertex];
                [set add:vertex]; // 注意：这句代码位置
            }
        }];
    }
}

#pragma mark   图的遍历 - DFS 前序遍历-栈实现
- (void)depthFirstSearch:(id)begin block:(MJGraphTraversalBlock)block {
    // 0、非空检测
    Vertex *vertex = [self.vertexs get:begin];
    if (vertex == nil) { return; }
    
    // 1.1、创建一个hashSet 保存已经遍历过的顶点
    HashSet *set = [[HashSet alloc] init];
    Stack *stack = [[Stack alloc] init];
    [stack push:vertex];
    [set add:vertex]; // 注意：这句代码位置
    
    while (!stack.isEmpty) {
        
        // 2、出队
        Vertex *vertex = [stack pop];
//        NSLog(@"%@", vertex);
        // 遍历器
        if (block) {
            block(vertex.value);
        }
        
        // 3、遍历inEdges 将边.to中 所有非重复顶点入队
        [vertex.outEdges traversalWithBlock:^(id  _Nonnull element) {
            Edge *edge =  (Edge *)element;
            Vertex *vertex = edge.to;
            
            if (![set contains:vertex]) { // 非重复顶点入队
                [stack push:vertex];
                [set add:vertex]; // 注意：这句代码位置
            }
        }];
    }
}

#pragma mark   图的遍历 - DFS 前序遍历-递归实现
- (void)depthFirstSearchCircle:(id)begin block:(MJGraphTraversalBlock)block {
    // 0、非空检测
    Vertex *vertex = [self.vertexs get:begin];
    if (vertex == nil) { return; }
    
    // 1、创建一个hashSet 保存已经遍历过的顶点
    HashSet *set = [[HashSet alloc] init];
    
    // 3.1、递归调用
    [self depthSearch:vertex set:set block:block];
}

- (void)depthSearch:(Vertex *)vertex set:(HashSet *)set block:(MJGraphTraversalBlock)block {
//        NSLog(@"%@", vertex);
    // 遍历器
    if (block) {
        block(vertex.value);
    }
    [set add:vertex]; // 注意：这句代码位置
    
    // 3.2、遍历inEdges 将边.to 递归调用
    [vertex.outEdges traversalWithBlock:^(id  _Nonnull element) {
        Edge *edge =  (Edge *)element;
        Vertex *vertex = edge.to;
        
        if (![set contains:vertex]) { // 非重复顶点 - 递归调用
            [self depthSearch:vertex set:set block:block];
        }
    }];
}


#pragma mark - AOV网问题 - 拓扑排序（卡恩算法）
/// 拓扑排序（卡恩算法）
- (NSMutableArray *)topologicalSort {
    
    // 0、初始化容器
    NSMutableArray *valueArray = [NSMutableArray array]; // 数组装排序好之后顶点的value
    HashMap *degreeMap = [[HashMap alloc] init]; // 保存入度不为o的顶点 维护这张HashMap
    Queue *queue = [[Queue alloc] init]; // 队列保存入度为0的顶点
    
    // 1、遍历所有顶点 找出入度为0的顶点 记录入度不为0的顶点
    for (Vertex *vertex in self.vertexs.allValues) {
        // 避免重复计算 用变量保存
        int degree = vertex.inEdges.size;
        if (degree == 0) { // 1.1、找出入度为0的顶点 入队queue
            [queue enQueue:vertex];
        }else { // 1.2、记录入度不为0的顶点 存入degreeMap
            [degreeMap put:vertex value:[NSNumber numberWithInt:degree]];
        }
    }
    
    // 2、顶点一个个出队 把value加入数组 degreeMap中度--
    while (!queue.isEmpty) {
        
        Vertex *vertex = [queue deQueue]; // 2.1、顶点一个个出队
        [valueArray addObject:vertex.value]; // 2.2、把value加入数组 相当于删除这个顶点
        
        // 3、遍历vertex.outEdges所有to顶点 将入度为1的顶点入队 其他顶点度--
        for (Edge *edge in vertex.outEdges.allElement) {
            
            Vertex *toVertex = edge.to;
            int degree = [[degreeMap get:toVertex] intValue]; // 从我们自己维护的degreeMap里取度
//            int degree = toVertex.inEdges.size; // 错误的：这个度是原来的图的入度
            
            if (degree == 1) { // 3.1、将入度为1的顶点入队
                [queue enQueue:toVertex];
            }else { // 3.2、其他顶点的入度-- 更新degreeMap
                [degreeMap put:toVertex value:[NSNumber numberWithInt:degree-1]];
            }
        }
    }
    
    
    return valueArray;
}

#pragma mark   AOE网问题

#pragma mark - 最小生成树问题（光缆铺设）- Prim算法（普里姆算法-切分定理）
/// Prim算法 （切分定理）
- (HashSet *)mstPrim {
    
    // 1、从图所有顶点中 随机取一个顶点
    NSMutableArray *verArr = self.vertexs.allValues;
    if (verArr.count == 0) {
        return nil;
    }
    Vertex *vertex = verArr.firstObject;
    
    // 返回给外界的边Set
    HashSet *edgeInfos = [[HashSet alloc] init];
    // 已经切分好或者将要切分的顶点Set
    HashSet *addedVertexs = [[HashSet alloc] init];
    // 2.1、切分操作 -  往addedVertexs里添加顶点（）
    [addedVertexs add:vertex];
    // 2.2、创建一个最小堆 选出outEdges里权重最小的边 （切分操作2）
    BinaryHeap *minHeap = [[BinaryHeap alloc] init];
    minHeap.heapType = HeapTypeSmall;
    for (Edge *edge in vertex.outEdges.allElement) {
        [minHeap add:edge];
    }
    
    // 堆不为空 && 还有顶点未切分
    int count = self.vertexs.size; // 计算数量耗时 放在条件前计算 只要计算一次就好
    while (!minHeap.isEmpty && addedVertexs.size < count) {
        
        // 3、选出权重最小的那条边edge
        Edge *topEdge = [minHeap remove]; // 出栈的有可能是之前已经切分过得边
        
        // 4.1 重复切分操作 - edge.to中未切分过的顶点加入addedVertexs
        Vertex *toVertex = topEdge.to;
        if ([addedVertexs contains:toVertex]) { // 排除已经切分过的顶点
            continue; // 已经切分过的顶点
        }
        [addedVertexs add:toVertex];
        
        [edgeInfos add:topEdge];
        
        // 4.2、重复切分操作 - 最小堆 选出outEdges里权重最小的边
        for (Edge *edge in toVertex.outEdges.allElement) {
            if ([addedVertexs contains:edge.to]) { // 排除已经切分过的顶点
                continue; // 已经切分过的顶点
            }
            [minHeap add:edge];
        }
    }
    
    return edgeInfos;
}

#pragma mark   最小生成树问题（光缆铺设）- Kruskal算法 (克鲁斯卡尔算法)
/// Kruskal算法 (顶点:n -> 边：n-1)
- (HashSet *)mstKruskal {
    // 1、 (顶点:n -> 边：n-1)
    int edgeSize = self.vertexs.size - 1;
    if (edgeSize < 0) { return  nil; }
    
    // 2、返回给外界的边Set
    HashSet *edgeInfos = [[HashSet alloc] init];
    
    // 3、创建一个最小堆
    BinaryHeap *minHeap = [[BinaryHeap alloc] init];
    minHeap.heapType = HeapTypeSmall;
    // 3.1、选出edges里权重最小的边
    for (Edge *edge in self.edges.allElement) {
        [minHeap add:edge];
    }
    
    // 4、创建一个并查集
    GenericUnionFind *uf = [[GenericUnionFind alloc] init];
    // 4.1、为所有顶点创建集合
    for (Vertex *vertex in self.vertexs.allValues) {
        [uf makeSet:vertex];
    }
    
    // 5、循环寻找权重最小 且 不会够成循环的边
    while (!minHeap.isEmpty && edgeInfos.size < edgeSize) {
        // 5.1、出堆 - 拿出堆顶元素（权重最小的边）
        Edge *edge = [minHeap remove];
        // 5.2、查看边2顶点是否在同一集合内
        if ([uf isSame:edge.from val:edge.to]) {
            // 5.3 在同一集合内 再添加 会构成环
            continue;
        }else {
            // 5.4 不在同一集合内 选出这条边
            [edgeInfos add:edge];
            // 5.5 合并这两个顶点
            [uf unionVal:edge.from val:edge.to];
        }
    }
    
    return edgeInfos;
}


#pragma mark - 最短路径问题 - 简单版 (拽石头-松弛操作）
/*
 * 有向图、无向图都支持
 * 从某一点出发的最短路径(权值最小)
 * 返回权值
 * 未优化代码
 */
- (HashMap *)shortestPath:(id)begin {
    // 0、取出开始值对应的顶点 空值校验
    Vertex *vertex = [self.vertexs get:begin];
    if (vertex == nil) { return nil; }
    
    // 1、等待被选择的路径s (key:toVertex value:weight) 从起点到其他点的路径信息
    HashMap *waitPaths   = [[HashMap alloc] init];
    for (Edge *edge in vertex.outEdges.allElement) {
        Vertex *toVertex = edge.to;
        [waitPaths put:toVertex value:@(edge.weight)];
    }
    
    // 2、已经确定的最小路径s 返回给外界  (key:vertex.value  value:weight)
    HashMap *finishPaths = [[HashMap alloc] init];
    // 5.1、原点首先加入 表示已处理
    [finishPaths put:vertex.value value:@0];
    
    // 3、筛选出最短路径 - 循环操作
    while (!waitPaths.isEmpty) {
        
        Vertex *minVertex = [self minWeightPath:waitPaths];

        // 3.1、将最短路径存入finishPaths
        id minWeight = [waitPaths get:minVertex];
        [finishPaths put:minVertex.value value:minWeight];
        
        // 3.2、将最短路径从waitPaths删除
        [waitPaths remove:minVertex];
        
        // 4、对minVertex.outEdges进行松弛操作 更新waitPaths路径
        for (Edge *edge in minVertex.outEdges.allElement) {
            // 4.1、松弛新节点
            Vertex *toVertex = edge.to;
            
            // 4.2、去除重复操作 - 无向路径可能会往回重复寻找
            if ([finishPaths containsKey:toVertex.value]) {
                continue;
            }
            
            // 4.3、原点到toVertex的新权重:edge.weight + minWeight
            double newWeight = edge.weight + [minWeight doubleValue];
            id oldWeight = [waitPaths get:toVertex];
            // 4.4、以前没有到原点的旧路径 oldWeight为nil
            // 4.5、以前有到原点的旧路径旧路径 且 newWeight < oldWeight
            if (oldWeight == nil || newWeight < [oldWeight doubleValue]) {
                // 4.6、更新松弛之后的waitPaths
                [waitPaths put:toVertex value:@(newWeight)];
            }
        }
    }

    // 5.2、原点最后要删除
    [finishPaths remove:vertex.value];
    return finishPaths;
}

/// 根据权值, 筛选权值最小的路径
- (Vertex *)minWeightPath:(HashMap *)waitPaths {
    Vertex *minVertex = nil;
    double minWeight = 0.0;
    
    for (Vertex *vertex in waitPaths.allkeys) {
        double weight = [[waitPaths get:vertex] doubleValue];
        if (minWeight == 0.0 || weight < minWeight) {
            minWeight = weight;
            minVertex = vertex;
        }
    }

    return minVertex;
}

/// 根据边信息, 筛选权值最小的路径
- (void)minPathInfo {
    
}


#pragma mark   单源最短路径算法1 - Dijkstra(迪杰斯特拉)
/*
 * Dijkstra: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
 * 不支持有负权边
 * 拽石头-松弛操作
 */
- (HashMap *)dijkstraShortPath:(id)begin {
    
    
    
    
    
    return nil;
}

#pragma mark   单源最短路径算法2 - BellmanFord(贝尔曼-福特)
/*
 * BellmanFord: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
 * 支持有负权边
 * 支持检测是否有负权环 第V次还有权重更新 则有负权环
 * 对所有边进行V-1次松弛操作（V是节点数量），得到所有可能的最短路径
 */
- (HashMap *)bellmanFordShortPath {
    
    
    
    return nil;
}

#pragma mark   多源最短路径算法 floydShortPath（弗洛伊德）
/*
 * Floyd: 多源最短路径算法,用于计算任意两个顶点的最短路径
 * 支持有负权边
 * 时间复杂度: O(V^3)
 */
- (HashMap *)floydShortPath {
    // 1、最小路径Map 返回给外界  (key:val  value:HashMap)
    // 嵌套HashMap: HashMap<fromVal, HashMap<toValue, Path<V, E>>>()
    HashMap *finishPaths = [[HashMap alloc] init];
    
    // 2、将所有边加入finishPaths
    for (Edge *edge in self.edges.allElement) {
        
        id fromVal = edge.from.value;
        HashMap *pathMap = [finishPaths get:fromVal];
        // 2.1、pathMap不存在 创建pathMap
        if (pathMap == nil) {
            pathMap = [[HashMap alloc] init];
            // 注意（key：fromVal  value:pathMap）
            [finishPaths put:fromVal value:pathMap];
        }
        
        // 2.2、pathMap存在 - 创建路径信息 存入pathMap
        // 创建路径信息
        Path *pathInfo = [[Path alloc] init];
        [pathInfo.edgeInfos addObject:edge];
        // 注意给Path个初始权值
        pathInfo.weight = edge.weight;
        // 注意（key：toValue  value:pathInfo）
        id toValue = edge.to.value;
        [pathMap put:toValue value:pathInfo];
    }
    
    // 3、三层for循环 遍历allkeys 顺序不能乱
    NSArray *values = self.vertexs.allkeys;
    for (id v2 in values) { // v2
        for (id v1 in values) { // v1
            for (id v3 in values) { // v3
                // 异常情况处理
                if (v1 == v2 || v2 == v3 || v1 == v3) { continue; }
                
                // v1 -> v2
                Path *path12 = [self getPathInfo:finishPaths from:v1 to:v2];
                if (path12 == nil) { continue; }
                // v2 -> v3
                Path *path23 = [self getPathInfo:finishPaths from:v2 to:v3];
                if (path23 == nil) { continue; }
                // v1 -> v3
                Path *path13 = [self getPathInfo:finishPaths from:v1 to:v3];
                
                // 新路径权重 - newWeight
                double newWeight = path12.weight + path23.weight;
                //  path13还不存在 创建path13
                if (path13 == nil) {
                    path13 = [[Path alloc] init];
                    HashMap *pathMap = [finishPaths get:v1];
                    [pathMap put:v3 value:path13];
                }else if (newWeight >= path13.weight ) {
                    // 权重：path12 + path23 >= path13 无需更新权重
                    continue;
                }
                
                // 权重：path12 + path23 < path13 更新权重weight
                path13.weight = newWeight;
                // 权重：path12 + path23 < path13 更新路径信息edgeInfos
                [path13.edgeInfos removeAllObjects];
                [path13.edgeInfos addObjectsFromArray:path12.edgeInfos];
                [path13.edgeInfos addObjectsFromArray:path23.edgeInfos];
            };
        };
    };
    
    return finishPaths;
}

/// 获取edge的路径信息
- (Path *)getPathInfo:(HashMap *)finishPaths from:(id)from to:(id)to {
    HashMap *pathMap = [finishPaths get:from];
    Path *pathInfo = [pathMap get:to];
    return pathInfo;
}

#pragma mark - 打印
- (void)printListGraph {
    
    for (id obj in self.vertexs.allValues) {
        
        Vertex *vertex = (Vertex *)obj;
        NSLog(@"---------%@：打印开始-----------",vertex.description);
        
        [vertex.inEdges traversalWithBlock:^(id  _Nonnull element) {
            NSLog(@"inEdges：%@", element);
        }];
        
        [vertex.outEdges traversalWithBlock:^(id  _Nonnull element) {
            NSLog(@"outEdges：%@", element);
        }];
        
        NSLog(@"---------%@：打印结束-----------",vertex.description);
    }
    
    NSLog(@"---------边打印开始-----------");
    [self.edges traversalWithBlock:^(id  _Nonnull element) {
        NSLog(@"%@", element);
    }];
    NSLog(@"---------边打印结束-----------");
}

@end
