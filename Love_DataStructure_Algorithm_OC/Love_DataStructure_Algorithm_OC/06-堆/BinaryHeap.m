//
//  BinaryHeap.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "BinaryHeap.h"

static int DEFAULT_CAPACITY = 10;

@interface BinaryHeap(){
    // 比较器-接口设计
    MJHeapComparatorBlock _comparatorBlock;
    id<MJHeapComparator> _comparator;
}

 
@end

@implementation BinaryHeap {
    NSMutableArray *elements;
}


#pragma mark - Treeheap - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        elements = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
        for (int i = 0 ; i < DEFAULT_CAPACITY; i++) {
            // 默认用NSNull占位
            [elements addObject:[NSNull null]];
        }
    }
    return self;
}

+ (instancetype)heap {
    return [self heapWithComparator:nil];
}

+ (instancetype)heapWithComparatorBlock:(_Nullable MJHeapComparatorBlock)comparatorBlock {
    BinaryHeap *heap = [[self alloc] init];
    heap->_comparatorBlock = comparatorBlock;
    
    heap->elements = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
    for (int i = 0 ; i < DEFAULT_CAPACITY; i++) {
        // 默认用NSNull占位
        [heap->elements addObject:[NSNull null]];
    }
    
    return heap;
}

+ (instancetype)heapWithComparator:(id<MJHeapComparator>)comparator {
    BinaryHeap *heap = [[self alloc] init];
    heap->_comparator = comparator;
    
    heap->elements = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
    for (int i = 0 ; i < DEFAULT_CAPACITY; i++) {
        // 默认用NSNull占位
        [heap->elements addObject:[NSNull null]];
    }
    
    return heap;
}


#pragma mark - override
/** 清空 */
- (void)clear {
    for (int i = 0; i < self.size; i++) {
        elements[i] = [NSNull null];
    }
    self.size = 0;
}

/** 获得堆顶元素 */
- (id)getTop {
    if (self.isEmpty) {
        return nil;
    }
    return elements[0];
}


#pragma mark - 添加删除替换
/** 添加元素 */
- (void)add:(id)element {
    if (element == nil) {
        return;
    }
    
    // 扩容检测
    [self ensureCapacity:(self.size + 1)];
    
    // 添加元素
    int index = self.size;
    elements[index] = element;
    
    // size++
    self.size++;
    
    // 上滤 - 性质修正
    [self siftUp:(self.size - 1)];
}

/** 删除堆顶元素 */
- (id)remove {
    
    // 0、空堆
    if (self.isEmpty) {
        return nil;
    }
    // 1、获得堆顶元素
    id root = [self getTop];
    

    // 2、数组最后一个元素替换堆顶元素root
    elements[0] = elements[(self.size - 1)];
    // 3、将数组最后一个元素删除
    elements[(self.size - 1)] = [NSNull null];
    // 5、siz--
    self.size--;
    
    // 6、下滤 - 性质修正
    [self siftDown:0];
    
    return root;
}

/** 删除堆顶元素的同时插入一个新元素 */
- (id)replace:(id)element {
    if (element == nil) {
        return nil;
    }
    
    // 0、默认top为空
    id root = NULL;
    
    if (self.size == 0) { // 1、特殊情况 堆为空  添加进去即可
        elements[0] = element;
        self.size++;
    } else {
        // 2、将新元素替换堆顶元素，再下滤
        root = elements[0];
        elements[0] = element;
        
        // 3、从0开始下滤 - 性质修正
        [self siftDown:0];
    }
    
    return root;
}


#pragma mark - 堆操作
/** 批量建堆 - 排序算法 */
- (void)heapify {
    // 方法一、自上而下的上滤 - 时间复杂度 O(nlongn)
//    for (int i = 1 ; i < self.size ; i++) {
//        [self siftUp:i];
//    }
    
    // 方法二、自下而上的下滤 - 时间复杂度 O(n)
    // 排除叶子结点:最后一个非叶子结点的索引-(self.size / 2 - 1)
    for (int i = ((self.size >> 1) - 1) ; i >= 0 ; i--) {
        [self siftDown:i];
    }
}


/** 让index位置的元素上滤  - 时间复杂度 O(longN) */
- (void)siftUp:(int)index {
    
    // 1、index > 0时 沿着父节点往上找，比父节点大，就交换位置，比父节点小就退出循环
    // 2、index == 0时 说明找到父节点位置 不需要再交换位置 终止循环
    
    // 0、保存element的值
    id element = elements[index];
    
    // 1、是否还有父节点
    while (index > 0) { // index == 0时 说明找到根节点位置 终止循环
        
        // 1.1、找到他的父节点 - floor((index - 1) / 2)
        int parentIndex = (index - 1) >> 1;
        id parent = elements[parentIndex];
        
        // 1.2、与父节点比较大小
        if ([self compareElement1:element element2:parent] <= 0) {
            break;
        }
        
        // 1.3、交换位置 - 将父元素交换到index位置
        elements[index] = parent;
        // 1.4、重新赋值index - node的索引位置index来到父元素位置
        index = parentIndex;
    }
    
    // 2、将node的值赋值到其索引位置
    elements[index] = element;
}


/**
 *完全二叉树性质
 *1、度为1的节点只有左子树
 *2、度为1的节点要么是1个，要么是0个
 *3、同样节点数量的二叉树，完全二叉树的高度最小
 *4、如果一颗完全二叉树有n个节点，那么其叶子结点个数n0 = floor((n + 1) / 2)，非叶子结点个数n1 + n2 = floor(n / 2)
 *5、如果一颗完全二叉树的高度为h (h>=1)，那么至少有2^(h - 1)个节点，至多有2^h - 1个节点（满二叉树）
*  h = floor(log2n) + 1
*/

/** 让index位置的元素下滤 - 时间复杂度 O(longN)*/
- (void)siftDown:(int)index {
    
    // 0、保存element的值
    id element = elements[index];
    int half = self.size >> 1;
    
/**
 * 完全二叉树: 其叶子结点个数n0 = floor((n + 1) / 2)，非叶子结点个数n1 + n2 = floor(n / 2)
 * 完全二叉树: 第一个叶子节点之后，全是叶子节点
 * 完全二叉树: 第一个叶子节点的索引 == 非叶子节点的数量  (self.size / 2)
 *
 * 必须保证index位置是非叶子节点    —>    index < 第一个叶子节点的索引
 * 第一个叶子节点的索引 == 非叶子节点的数量    —>   index < half
*/
    
    // 1、必须保证index位置是非叶子节点
    while (index < half) { // 必须保证index位置是非叶子节点
        // 完全二叉树index的节点有2种情况 (index是父节点编号  左子节点编号：2*index + 1  右子节点编号：2*index + 2)
        // 1.1 只有左子节点 (有左子节点：2*index + 1 < self.size 无左子节点： 2*index + 1 >= self.size)
        // 1.2 同时有左右子节点 选出左右子节点最大的那个 (有右子节点：2*index + 2 < self.size 无右子节点：2*index + 2 >= self.size )
        
        // 左子节点索引 （2*index + 1）
        int childIndex = (index << 1) + 1;
        id child = elements[childIndex];
        
        // 右子节点索引 （2*index + 2）
        int rightIndex = childIndex + 1;
        
        // 2、选出左右子节点最大的那个
        if (rightIndex < self.size) { // 算出来的索引要小于数组长度 否则会越界
            
            if ([self compareElement1:elements[rightIndex] element2:child] > 0) { // 右子节点大 就替换child
                childIndex = rightIndex;
                child = elements[rightIndex];
            }
        }
        
        // 3、与其最大的那个子节点比较大小 element >= child 就停止while循环
        if ([self compareElement1:element element2:child] >= 0) {
            break;
        }
        
        // 4、element < child 继续下滤
        // 4.1、将子节点存放到index位置
        elements[index] = child;
        // 4.2、更新index
        index = childIndex;
    }
    
    // 5、将node的值赋值到其索引位置
    elements[index] = element;
}

#pragma mark - 比较器
/** 比较两元素的大小 */
- (int)compareElement1:(id)element1 element2:(id)element2 {
    
    int result = _comparatorBlock ? _comparatorBlock(element1, element2) :
    (_comparator ? (int)[_comparator compareElement1:element1 another:element2] : (int)[element1 compare:element2]);
    
    if (self.heapType == HeapTypeSmall) {
        result = -result;
    }
    
    return result;
}


#pragma mark - 动态数组扩容➕动态数组缩容
/**动态数组扩容**/
- (void)ensureCapacity:(int)capacity {
    int oldCapacity = (int)elements.count;
    if (oldCapacity >= capacity) {
        return;
    }
    
    // 新容量为旧容量的1.5倍
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    NSMutableArray *newElements = [NSMutableArray arrayWithCapacity:newCapacity];
    for (int i = 0; i < newCapacity; i++) {
        // 默认用NSNull占位
        [elements addObject:[NSNull null]];
    }
    
    // 旧值设回
    for (int i = 0; i < self.size; i++) {
        newElements[i] = elements[i];
    }
    elements = newElements;
}

/**动态数组缩容**/

#pragma mark - 堆排序



#pragma mark - 打印BinaryHeap
- (NSString *)description {
    [super description];
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:[NSString stringWithFormat:@"size = %d",self.size]];
    [strM appendString:@", ["];
    
    for (int i = 0; i < elements.count; i++) {
        if (i != 0) {
            [strM appendString:@", "];
        }
        [strM appendString:[NSString stringWithFormat:@"%@",elements[i]]];
    }
    
    [strM appendString:@"]"];
    return strM.copy;
}


#pragma mark - 实现MJBinaryTreeInfo协议方法-打印
- (id)string:(id)node { // 重写
    int index =  [node intValue];
    id obj = elements[index];
    return obj;
}


@end
