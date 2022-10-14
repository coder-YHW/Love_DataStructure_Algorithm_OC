//
//  main.m
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import <Foundation/Foundation.h>

#import "ArrayList.h"
#import "ArrayListUpgrade.h"
#import "LinkedList.h"
#import "DoubleLinkList.h"
#import "SingleCircleLinkedList.h"
#import "DoubleCircleLinkedList.h"

#import "Queue.h"
#import "Deque.h"
#import "CircleQueue.h"
#import "CircleDeque.h"

#import "MJBinaryTrees.h"
#import "BSTree.h"
#import "AVLTree.h"
#import "RBTree.h"
#import "TreeMap.h"

#import "HashMap.h"
#import "LinkHashMap.h"
#import "BinaryHeap.h"


#pragma mark - 动态数组测试用例
void testArrayList(void) {
 
//    ArrayList *arrayList = [[ArrayList alloc] initWithCapaticy:10];
//    NSArray *data = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12];
//    for(NSObject *obj in data ) {
//        [arrayList add:obj];
//    }
//    NSLog(@"%@", arrayList);
//
//    [arrayList remove:5];
//    NSLog(@"%@", arrayList);

//    [arrayList set:10 element:@20];
//    NSLog(@"%@", arrayList);
//
//    [arrayList add:5 element:@6];
//    NSLog(@"%@", arrayList);
//
//    [arrayList clear];
//    NSLog(@"%@", arrayList);

    
    
    ArrayListUpgrade *arrayList = [[ArrayListUpgrade alloc] initWithCapaticy:10];
    NSLog(@"%@", arrayList);

    // 在数组开头添加元素
//    [arrayList add:0 element:@0];
//    NSLog(@"%@", arrayList);
//    [arrayList add:0 element:@1];
//    NSLog(@"%@", arrayList);
//    [arrayList add:0 element:@2];
//    NSLog(@"%@", arrayList);
//    [arrayList add:0 element:@3];
//    NSLog(@"%@", arrayList);
    
    // 测试查询修改
//    id a = [arrayList get:3];
//    NSLog(@"%@", a);
//    [arrayList set:3 element:@10];
//    NSLog(@"%@", arrayList);
//    int b = [arrayList indexOfElement:@2];
//    NSLog(@"%d", b);
////    [arrayList clear];
//    NSLog(@"%@", arrayList);
    
    // 在数组末尾添加元素
    [arrayList add:@0];
    NSLog(@"%@", arrayList);
    [arrayList add:@1];
    NSLog(@"%@", arrayList);
    [arrayList add:@2];
    NSLog(@"%@", arrayList);
    [arrayList add:@3];
    NSLog(@"%@", arrayList);
    
//    // 在数组中间添加元素
//    [arrayList add:1 element:@4];
//    NSLog(@"%@", arrayList);
//    [arrayList add:1 element:@5];
//    NSLog(@"%@", arrayList);
//    [arrayList add:1 element:@6];
//    NSLog(@"%@", arrayList);
//    [arrayList add:1 element:@7];
//    NSLog(@"%@", arrayList);

    // 在数组中间删除元素
//    [arrayList remove:1];
//    NSLog(@"%@", arrayList);
//    [arrayList remove:1];
//    NSLog(@"%@", arrayList);
//    [arrayList remove:1];
//    NSLog(@"%@", arrayList);
//    [arrayList remove:1];
//    NSLog(@"%@", arrayList);
    
//    // 删除数组开头元素
//    [arrayList remove:0];
//    NSLog(@"%@", arrayList);
//    [arrayList remove:0];
//    NSLog(@"%@", arrayList);
//    [arrayList remove:0];
//    NSLog(@"%@", arrayList);
//    [arrayList remove:0];
//    NSLog(@"%@", arrayList);
//    [arrayList remove:0];
//    NSLog(@"%@", arrayList);
    
    // 删除数组末尾元素
    [arrayList remove:arrayList.size-1];
    NSLog(@"%@", arrayList);
    [arrayList remove:arrayList.size-1];
    NSLog(@"%@", arrayList);
    [arrayList remove:arrayList.size-1];
    NSLog(@"%@", arrayList);
    [arrayList remove:arrayList.size-1];
    NSLog(@"%@", arrayList);
    

//    [arrayList remove:0];
//    NSLog(@"%@", arrayList);
    
}


#pragma mark - 队列测试用例
void testQueue(void) {
    
    Queue *queue = [[Queue alloc] init];
    NSArray *data = @[@1, @2, @3, @4];
    for(NSObject *obj in data ) {
        [queue enQueue:obj];
        NSLog(@"%@", queue);
    }

    while (!queue.isEmpty) {
        [queue deQueue];
        NSLog(@"%@", queue);
    }
 
    
//    CircleQueue *queue = [[CircleQueue alloc] init];
//    NSArray *data = @[@1, @2, @3, @4];
//    for(NSObject *obj in data ) {
//        [queue enQueue:obj];
//        NSLog(@"%@", queue);
//    }
//
//    while (!queue.isEmpty) {
//        [queue deQueue];
//        NSLog(@"%@", queue);
//    }

    
//    CircleDeque *queue = [[CircleDeque alloc] init];
//    NSArray *data = @[@1, @2, @3, @4];
//    for(NSObject *obj in data ) {
//
//        if(queue.size % 2) {
//            [queue enQueueRear:obj];
//        }else {
//            [queue enQueueFront:obj];
//        }
//
//        NSLog(@"%@", queue);
//    }
//
//    while (!queue.isEmpty) {
//
//        if(queue.size % 2) {
//            [queue deQueueRear];
//        }else {
//            [queue deQueueFront];
//        }
//
//        NSLog(@"%@", queue);
//    }
    
}
    

#pragma mark - 链表测试用例
void testLinkList(void) {
    
    // 约瑟夫问题
    DoubleCircleLinkedList *linkList = [[DoubleCircleLinkedList alloc] init];
//    SingleCircleLinkedList *linkList = [[SingleCircleLinkedList alloc] init];
    NSArray *data = @[@1, @2, @3, @4, @5, @6, @7, @8];
    for(NSObject *obj in data ) {
        [linkList add:obj];
    }
    NSLog(@"%@", linkList);
    
    [linkList reset];

    while (!linkList.isEmpty) {
        [linkList next];
        [linkList next];
        [linkList remove];
        NSLog(@"%@", linkList);
    }
}


#pragma mark - 打印二叉树
/**打印二叉树方法 - MJMJPrinter ➕ MJBinaryTreeInfo协议 **/
void binaryTreePrint(id<MJBinaryTreeInfo> tree) {
    // 0、默认上下展示二叉树
    [MJBinaryTrees println:tree];
    
    // 1、上下展示二叉树
//    [MJBinaryTrees println:bst style:MJPrintStyleLevelOrder];
    
    // 2、左右展示二叉树
//    [MJBinaryTrees println:bst style:MJPrintStyleInorder];
    
    // 3、将二叉树转成字符串 写入本地文件
//    NSString *str = [MJBinaryTrees printString:bst];
//    NSString *file = @"/Users/mj/Desktop/bst.txt";
//    [str writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


/**
 * Warning -This old-style function definition is not preceded by a prototype
 * 即使函数括号内没有任何参数，也要加一个void类型，来避免这种warning
 */
#pragma mark - 二叉搜索树测试用例
void testBST1(void) {

    // 1、创建二叉搜索树
    BSTree *bst = [BSTree tree];
    
    // 2、添加节点数据
    NSArray *array = @[@7, @4, @9, @2, @5, @8, @11];
//    NSArray *array = @[@7, @4, @9];
    for (id elemennt in array) {
        [bst add:elemennt];
    }
    
    // 打印二叉树
    binaryTreePrint(bst);
    
    // 3.1、删除节点数据
    [bst removeElement:@8];
    binaryTreePrint(bst);
    
    // 3.2、删除节点数据
    [bst removeElement:@5];
    binaryTreePrint(bst);
}

void testBST2(void) {

    // 1、创建二叉搜索树 - 比较器Block
    BSTree *bst = [BSTree treeWithComparatorBlock:^int(id  _Nonnull e1, id  _Nonnull e2) {
//        return [e1 compare:e2]; // 顺序添加节点
        return (int)[e2 compare:e1]; // 逆序添加节点
    }];
    
    // 2.2、添加节点数据
    int data[] = {38, 18, 4, 69, 85, 71, 34, 36, 29, 100};
    int len = sizeof(data) / sizeof(int);
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    
    // 打印二叉树
    binaryTreePrint(bst);
    
    // 3.1、删除节点数据
    [bst removeElement:@71];
    binaryTreePrint(bst);

    // 3.2、删除节点数据
    [bst removeElement:@18];
    binaryTreePrint(bst);
}

#pragma mark - AVL树测试用例
void testAVL(void) {
    
    // 1、创建二叉搜索树
    AVLTree *avl = [AVLTree tree];
    
    // 2、添加节点数据
    int data[] = {2, 98, 100, 84, 7, 42, 20, 63, 53, 95, 91, 28, 19, 75, 59, 99, 29, 86};
    int len = sizeof(data) / sizeof(int);
    for (int i = 0; i < len; i++) {
        [avl add:@(data[i])];
    }
    
    // 打印二叉树
    binaryTreePrint(avl);
    
    // 3.1、删除节点数据
    [avl removeElement:@20];
    binaryTreePrint(avl);

    // 3.2、删除节点数据
    [avl removeElement:@86];
    binaryTreePrint(avl);
}

#pragma mark - 红黑树测试用例
void testRBT(void) {
    
    // 1、创建二叉搜索树 - 比较器Block
    RBTree *rbt = [RBTree tree];
    
    // 2.2、添加节点数据
    int data[] = {55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50};
//    int data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
//    int data[] = {0, 1, 2};

    int len = sizeof(data) / sizeof(int);
    for (int i = 0; i < len; i++) {
        [rbt add:@(data[i])];
    }
    
    // 打印二叉树
    binaryTreePrint(rbt);
}

#pragma mark - 映射测试用例
void testTreeMap(void) {
    
    // 1、创建TreeMap - 比较器Block
    TreeMap *treeMap = [TreeMap map];
    
    // 2.2、添加节点数据
//    NSArray *keys = @[@55, @87, @56, @74, @96, @22, @62, @20, @70, @68, @90, @50];
//    NSArray *values = @[@55, @87, @56, @74, @96, @22, @62, @20, @70, @68, @90, @50];
    
    NSArray *keys = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11];
    NSArray *values = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11];
//    NSArray *values = @[@"张三", @"李四", @"王五", @"余一", @"全二", @"赵六", @"周八", @"罗氏", @"韩思", @"纷纷", @"娃娃", @"bbay"];
    
    for (int i = 0; i < keys.count; i++) {
        [treeMap put:keys[i] value:values[i]];
    }
    
    // 打印treeMap
    binaryTreePrint(treeMap);
    
    // 遍历MJTraversalBlock
    [treeMap traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
        NSLog(@"%@:%@", key, value);
    }];
}


#pragma mark - 哈希表测试用例
void testHashMap(void) {
    
    // 1、创建TreeMap - 比较器Block
//    HashMap *hashMap = [[HashMap alloc] init];
    LinkHashMap *hashMap = [[LinkHashMap alloc] init];
      
//    NSArray *keys = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11];
//    NSArray *values = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11];
//    NSArray *values = @[@"张三", @"李四", @"王五", @"余一", @"全二", @"赵六", @"周八", @"罗氏", @"韩思", @"纷纷", @"娃娃", @"bbay"];
    
    // 添加节点数据
    [hashMap put:@"11" value:@"11"];
    [hashMap put:@"22" value:@"22"];
    [hashMap put:@"33" value:@"33"];
    
    // 批量添加节点数据
    NSArray *keys = @[@"55", @"87", @"56", @"74", @"96", @"22", @"62", @"20", @"70", @"68", @"90", @"50"];
    NSArray *values = @[@"55", @"87", @"56", @"74", @"96", @"22", @"62", @"20", @"70", @"68", @"90", @"50"];
    for (int i = 0; i < keys.count; i++) {
        [hashMap put:keys[i] value:values[i]];
    }

    BOOL isContainsKey = [hashMap containsKey:@"11"];
    BOOL isContainsValue = [hashMap containsValue:@"33"];
    id value = [hashMap get:@"22"];
    NSLog(@"isContainsKey-1:%d \n isContainsValue-3:%d \n value-2:%@", isContainsKey, isContainsValue, value);

    
    [hashMap remove:@"33"];
    NSLog(@"删除@3");
    
    // 遍历MJTraversalBlock
    [hashMap traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
        NSLog(@"MJTraversalBlock - %@:%@", key, value);
    }];
    
    // 打印hashMap
    [hashMap printHashMap];
}

#pragma mark - 堆测试用例
void testBinaryHeap(void) {
    
//    BinaryHeap *heap = [BinaryHeap heap];
//    heap.heapType = HeapTypeSmall; // 堆类型
//
//    NSArray *keys = @[@68, @72, @43, @50, @38, @10, @90, @65];
//    for (int i = 0; i < keys.count; i++) {
//        [heap add:keys[i]];
//    }
//
//    // 打印heap
//    NSLog(@"%@", heap.description);
//    [MJBinaryTrees println:heap];
//
//    [heap remove];
//    NSLog(@"%@", heap.description);
//    [MJBinaryTrees println:heap];
//
//    [heap replace:@30];
//    NSLog(@"%@", heap.description);
//    [MJBinaryTrees println:heap];
    
    // 一、Top K问题：找出数组里最大的前K个数 - 时间复杂度O(nlongk)
    BinaryHeap *heap = [BinaryHeap heap];
    heap.heapType = HeapTypeSmall; // 堆类型
    
    NSArray *keys = @[@"55", @"87", @"56", @"74", @"96", @"22", @"62", @"20", @"70", @"68", @"90", @"50"];
    int k = 3;
    
    for (int i = 0 ; i < keys.count ; i++) { // 1、创建一个小顶堆 讲前k个数加入堆中
        id obj = keys[i];
        if (i < k) {
            [heap add:obj];
        }else if ([heap.get compare:obj] < 0) { // 2、第k+1个数开始 如果大于堆顶元素就替换
            [heap replace:obj];
        }
    }
    
    NSLog(@"%@", heap.description);
    [MJBinaryTrees println:heap];
    
    // 二、堆排序问题
    
}


#pragma mark - main函数
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 动态数组验证
//        testArrayList();
        
        // 链表验证
//        testLinkList();
        
        // 队列验证
//        testQueue();
        
        // BST树验证 - 二叉搜索树
//        testBST1();
//        testBST2();
        
        // AVL树验证 - AVL树
//        testAVL();
        
        // RBT树验证 - 红黑树
        testRBT();
        
        // TreeMap验证 - 映射
//        testTreeMap();
        
        // HashMap验证 - 哈希表
//        testHashMap();
        
        // BinaryHeap验证 - 二叉堆
//        testBinaryHeap();
    }
    return 0;
}


