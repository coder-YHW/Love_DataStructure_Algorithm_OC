//
//  ListGraph.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import "ListGraph.h"
#import "HashMap.h"
#import "HashSet.h"
#import "Vertex.h"
#import "Edge.h"
#import "Queue.h"
#import "Stack.h"

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

#pragma mark - 最小生成树问题（光缆铺设）- Prim算法
- (HashSet *)mstPrim {
    
    // 1、从图所有顶点中 随机取一个顶点
    NSMutableArray *verArr = self.vertexs.allValues;
    if (verArr.count == 0) {
        return [[HashSet alloc] init];
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

#pragma mark - 最小生成树问题（光缆铺设）- Kruskal算法

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
