//
//  HashMap.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//


#import "HashMap.h"
#import "Queue.h"
#import "MJBinaryTrees.h"

static int DEFAULT_CAPACITY = 1 << 4; // table桶数组长度
static float DEFAULT_LOAD_FACTOR = 0.75; // 装填因子 = 哈希表节点总数量 / 哈希表桶数组长度; 如果装填因子超过0.75 就扩容为原来的2倍

@interface HashMap()

/** size*/
@property (nonatomic,assign) int size;
/** table*/
@property (nonatomic,strong) NSMutableArray *table; // <HashNode *> 红黑树根节点数组

@end

@implementation HashMap{
    HashNode *printRoot; // 需要打印的红黑树根节点
}

#pragma mark - TreeMap - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        self.table = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
        for (int i = 0; i < DEFAULT_CAPACITY; i++) {
            [self.table addObject:[NSNull null]];
        }
        self.size = 0;
    }
    return self;
}


#pragma mark - 初始化 - HashNode  - 子类可以重写
/** 初始化 - HashNode  - 子类可以重写*/
- (HashNode *)createNodeWithKey:(id)key value:(id)value parent:(nullable HashNode *)parent {
    return [[HashNode alloc] initWithKey:key value:value parent:parent];
}


#pragma mark - override
/**元素个数*/
- (int)size { // self.size 其实是调用这个方法的 所以返回值不能是self.size 会循环调用卡死
    return _size;
}

/**是否为空*/
- (BOOL)isEmpty {
    return self.size == 0;
}

/**清除所有元素*/
- (void)clear {
    if (self.size == 0) {
        return;
    }
    
    for (int i = 0 ; i < self.table.count ; i++) {
        self.table[i] = [NSNull null];
    }
    self.size = 0;
}

- (id)get:(id)key {

    HashNode *node = [self getNodeFromKey:key];
    if ([self isNullObject:node]) {
        return nil;
    }else {
        return node.value;
    }
}

- (BOOL)containsKey:(id)key {
    return [self get:key] != nil;
}


- (BOOL)containsValue:(id)value {
    if (self.size == 0) {
        return false;
    }
    
    
    for (id obj in self.table) { // 遍历每一张红黑树

        if ([self isNullObject:obj]) { // 0、[NSNull null] 空树 下一个
            continue;
        }

        HashNode *root = (HashNode *)obj;
        Queue *queue = [[Queue alloc] init];
        [queue enQueue:root];

        while (!queue.isEmpty) { // 1、根节点入队 再层序遍历整棵树

            HashNode *node = [queue deQueue];
            if ([self valEquals:value v2:node.value]) { // 2、value相等则包含
                return YES;
            }

            if (node.left != nil) {
                [queue enQueue:node.left];
            }

            if (node.right != nil) {
                [queue enQueue:node.right];
            }
        }
    }

    return false; // 3、遍历完都没找到 则不包含
}

/**层序遍历*/
- (void)traversalWithBlock:(MJMapTraversalBlock)block {
    
    if (self.size == 0) {
        return;
    }

    for (id obj in self.table) { // 遍历每一张红黑树
        
        if ([obj isEqual:[NSNull null]]) { // [NSNull null] 空树
            continue;
        }
        
        HashNode *root = (HashNode *)obj;
        Queue *queue = [[Queue alloc] init];
        [queue enQueue:root];

        while (!queue.isEmpty) {
            
            HashNode *node = [queue deQueue];
            // MJMapTraversalBlock
            if (block) {
                block(node.key, node.value);
            }

            if (node.left != nil) {
                [queue enQueue:node.left];
            }

            if (node.right != nil) {
                [queue enQueue:node.right];
            }
        }
    }
}


#pragma mark - 添加元素
/**添加元素*/
- (void)put:(id)key value:(id)value {
    if ([self keyNotNullCheck:key]) {
        return;
    }
    
    int index = [self getHashIndexFromKey:key];
    HashNode *root = self.table[index];
    
    // 1、添加第一个节点
    if ([self isNullObject:root]) {
        root = [self createNodeWithKey:key value:value parent:nil];
        self.table[index] = root; // 将根节点放入到桶数组里 注意：一定不要忘了这一句
        _size++;
        
        // 5、新添加节点之后的处理
        [self afterPut:root];
        return;
    }
    
    // 2、添加的不是第一个节点
    // 此时哈希冲突（不同的key得哈希化后得到了相同的hashCode）
    HashNode *parent = root;
    HashNode *node = root;
    int cmp = 0;
    
    // 3、找到要添加位置的父节点
    while (node != nil) { // 这里不可能是Null 只有根节点才有可能是Null
        cmp = [self compareElement1:key element2:node.key hashCode1:[self getHashCodeFromKey:key] hashCode2:node.hashCode];
        parent = node; // 找到父节点
        
        if (cmp > 0) {  // 右节点
            node = node.right;
        } else if (cmp < 0) {   // 左节点
            node = node.left;
        } else {    // key相等 - value覆盖
            node.key = key;
            node.value = value;
//            node.hashCode = [self getHashCodeFromKey:key]; // 此处hashCode替不替换都可以 hashCode是相等的
            return;
        }
    }
    
    // 4、查看插入到父节点的哪个位置
    HashNode *newNode = [self createNodeWithKey:key value:value parent:parent];
    if (cmp > 0) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }
    _size++;
    
    /// 5、添加节点之后的处理
    [self afterPut:newNode];
}

/**添加之后平衡**/
- (void)afterPut:(HashNode *)node {
//    NSLog(@"afterAdd : 平衡二叉搜索树 - 子类实现");
    
    HashNode *parent = node.parent;
    
    // 1、添加的是根节点,或者上溢到达了根节点
    // 1.1、将自己染黑就行了
    if (parent == nil) {
        [self black:node];
        return;
    }
    
    // 红黑红、黑红、红黑、黑 - 总共12种情况
    // 2、如果父节点是黑色,直接返回 - 新添加的节点默认是红色的
    if ([self isBlack:parent]) { //（红黑红、黑红、红黑、黑 - 往黑节点上添加）4种情况
        return;
    }
    
    // 叔父节点
    HashNode *uncle = parent.sibling;
    // 祖父节点
    HashNode *grand = parent.parent;
    
    // 3、父节点是红色&&叔父节点是红色[B树节点上溢] - （红黑红-往红节点上添加）4种情况
    if ([self isRed:uncle]) {
        // 3.1、将grand染红，父节点、叔父节点都染黑
        [self black:parent];
        [self black:uncle];
        // 3.2、等价于 - 将祖父节点当做是新添加的节点
        [self red:grand];
        [self afterPut:grand];
        return;
    }
    
    // 4、父节点是红色&&叔父节点不是红色 - （黑红或红黑-往红节点上添加）4种情况
    if (parent.isLeftChild) {   // L
        if (node.isLeftChild) { // LL
            // 4.1、将grand染红，父节点染黑，再旋转
            [self red:grand];
            [self black:parent];
        } else {    // LR
            // 4.2、将grand染红，自己染黑，再旋转
            [self red:grand];
            [self black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else {    // R
        if (node.isLeftChild) { // RL
            // 4.3、将grand染红，自己染黑，再旋转
            [self red:grand];
            [self black:node];
            [self rotateRight:parent];
        } else {    // RR
            // 4.4、将grand染红，父节点染黑，再旋转
            [self red:grand];
            [self black:parent];
        }
        [self rotateLeft:grand];
    }
}


#pragma mark - 删除元素
/** 删除元素 */
- (void)remove:(id)element {
    [self removeNode:[self getNodeFromKey:element]];
}

 /** 删除节点 node */
- (void)removeNode:(HashNode *)node {
    if (node == nil) {
        return;
    }
    
    self.size--;
    
    if (node.hasTwoChildren) {  // 度为2的节点
        // 找到后继节点
        HashNode *nextNode = [self nextNode:node];
        // 用后继节点的值覆盖度为2的节点的值
        node.key = nextNode.key;
        node.value = nextNode.value;
        node.hashCode = nextNode.hashCode;
        // color和parent在下面调整
        // 删除后继节点
        node = nextNode;
        
        // 1、修复LinkHashMap性质
        [self fixRemoveNode1:node replace:nextNode];
    }
    
    // 删除node节点(node的度必然是1或者0)
    HashNode *replacement = node.left != nil ? node.left : node.right;
    
    if (replacement != nil) {   // 1.node是度为1的节点
        // 更改parent
        replacement.parent = node.parent;
        // 更改parent的left,right的指向
        if (node.parent == nil) {   // node是度为1的节点并且是根节点
            int index = [self getHashIndexFromHashCode:node.hashCode];
            self.table[index] = replacement;
        } else if (node == node.parent.left) {  // 左子节点
            node.parent.left = replacement;
        } else {    // node == node.parent.right
            node.parent.right = replacement;
        }
    } else if (node.parent == nil) {    // 2.node是叶子节点并且是根节点
        int index = [self getHashIndexFromHashCode:node.hashCode];
        self.table[index] = [NSNull null];
    } else {    // 3.node是叶子节点,但不是根节点
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {    // node == node.parent.right
            node.parent.right = nil;
        }
    }
    
    /// 删除节点之后的处理
    [self afterRemove:node];
    
    // 2、修复LinkHashMap性质
    [self fixRemoveNode2:node];
}

/**删除之后再平衡**/
- (void)afterRemove:(HashNode *)node {
    // 如果删除的节点是红色
    // 或者用以取代删除节点的子节点是红色
    if ([self isRed:node]) {
        [self black:node];
        return;
    }
    
    HashNode *parent = node.parent;
    // 删除的是根节点
    if (parent == nil) {
        return;
    }
    
    // 删除的是黑色叶子节点[下溢]
    // 判断被删除的node是左还是右
    BOOL left = parent.left == nil || node.isLeftChild;
    HashNode *sibling = left ? parent.right : parent.left;
    
    if (left) { // 被删除的节点在左边,兄弟节点在右边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            
            // 更换兄弟
            sibling = parent.right;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有一个红色节点,父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            
            if (parentBlack) {
                [self afterRemove:parent];
            }
        } else {    // 兄弟节点至少有一个红色节点,向兄弟节点借元素
            // 兄弟节点的左边时黑色,兄弟要先旋转
            if ([self isBlack:sibling.right]) {
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            
            [self color:sibling color:[self colorOf:parent]];
            [self black:sibling.right];
            [self black:parent];
            [self rotateLeft:parent];
        }
    } else {    // 被删除的节点在右边,兄弟节点在左边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            
            // 更换兄弟
            sibling = parent.left;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有一个红色节点,父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            
            if (parentBlack) {
                [self afterRemove:parent];
            }
        } else {    // 兄弟节点至少有一个红色子节点,向兄弟节点借元素
            // 兄弟节点的左边时黑色,兄弟要先旋转
            if ([self isBlack:sibling.left]) {
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            
            [self color:sibling color:[self colorOf:parent]];
            [self black:sibling.left];
            [self black:parent];
            [self rotateRight:parent];
        }
    }
}


#pragma mark - 平衡红黑树-旋转
/** 左旋转 grand - 爷爷节点 */
- (void)rotateLeft:(HashNode *)grand {
    
    HashNode *parent = grand.right;
    HashNode *node = parent.left;
    
    // 1、移动parent.left节点
    grand.right = parent.left;
    parent.left = grand;
    
    // 2、依次更新parent、node、grand的grand
    [self afterRotate:grand parent:parent child:node];
}

/** 右旋转 */
- (void)rotateRight:(HashNode *)grand {
    
    HashNode *parent = grand.left;
    HashNode *node = parent.right;
    
    // 1、移动parent.right节点
    grand.left = parent.right;
    parent.right = grand;
    
    // 2、依次更新parent、node、grand的grand
    
    [self afterRotate:grand parent:parent child:node];
}

/** 按照顺序更新节点的parent： 1、parent.parent  2、child.parent  3、grand.parent*/
- (void)afterRotate:(HashNode *)grand parent:(HashNode *)parent child:(HashNode *)node {
    // 1.1、让parent成为子树的根节点
    parent.parent = grand.parent;
    
    // 1.2、让grand.parent指向parent
    if (grand.isLeftChild) { // grand是左子树
        grand.parent.left = parent;
    } else if (grand.isRightChild) { // grand是右子树
        grand.parent.right = parent;
    } else {    // grand是root节点
//        root = parent; // 原代码
        
        int index = [self getHashIndexFromHashCode:grand.hashCode];
        self.table[index] = parent;
    }
    
    // 2、更新node的grand
    if (node != nil) {
        node.parent = grand;
    }
    
    // 3、更新grand的parent
    grand.parent = parent;
}

#pragma mark - 平衡红黑树-染色
- (HashNode *)color:(HashNode *)node color:(HashNodeType)HashNodeType {
    if (node == nil) {
        return node;
    }
    
    node.color = HashNodeType;
    return node;
}

- (HashNode *)red:(HashNode *)node {
    return [self color:node color:HashNodeTypeRed];
}

- (HashNode *)black:(HashNode *)node {
    return [self color:node color:HashNodeTypeBlack];
}

- (HashNodeType)colorOf:(HashNode *)node {
    return node == nil ? HashNodeTypeBlack : node.color;
}

- (BOOL)isBlack:(HashNode *)node {
    return [self colorOf:node] == HashNodeTypeBlack;
}

- (BOOL)isRed:(HashNode *)node {
    return [self colorOf:node] == HashNodeTypeRed;
}

#pragma mark - 前驱节点 和 后继节点
/** 找前驱节点 */
- (HashNode *)prevNode:(HashNode *)node {
    if (node == nil) {
        return nil;
    }
    
    /** 1.左子树不为空
     前驱节点在左子树当中（left.right.right.right....）
     */
    HashNode *p = node.left;
    if (p != nil) {
        while (p.right != nil) {
            p = p.right;
        }
        return p;
    }
    
    /** 2.左子树为空,父节点不为空
     从父节点、祖父节点中寻找前驱节点
     */
    while (node.parent != nil && node == node.parent.left) {
        node = node.parent;
    }
    
    // node.parent == null
    // node == node.parent.right
    return node.parent;
}

/** 找后继节点 */
- (HashNode *)nextNode:(HashNode *)node {
    if (node == nil) {
        return nil;
    }
    
    /** 1.右子树不为空
     前驱节点在左子树当中（node.right.left.left.left....）
     */
    HashNode *p = node.right;
    if (p != nil) {
        while (p.left != nil) {
            p = p.left;
        }
        return p;
    }
    
    /** 2.右子树为空,父节点不为空
     从父节点、祖父节点中寻找前驱节点
     */
    while (node.parent != nil && node == node.parent.right) {
        node = node.parent;
    }
    
    return node.parent;
}

#pragma mark - private
- (BOOL)keyNotNullCheck:(id)key {
    return key == nil;
}


/**NullObjec校验**/
- (BOOL)isNullObject:(id)obj {
    
    if ([obj isEqual:[NSNull null]]) {
        return YES;
    }else {
        return NO;
    }
}


#pragma mark - 把key哈希化成hashIndex
/**把key转化成hashIndex*/
- (int)getHashIndexFromKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    int hashCode = (int)[key hash]; // 1、哈希函数
    hashCode = hashCode ^ (hashCode >> 16); // 2、向右偏移16位, 做异或操作
    
    hashCode = hashCode & (self.table.count - 1); // 3、异或 (self.table.count - 1)
    
    return hashCode;
}

/**把key哈希化成hashCode**/
- (int)getHashCodeFromKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    int hashCode = (int)[key hash]; // 1、哈希函数
    hashCode = hashCode ^ (hashCode >> 16); // 2、向右偏移16位, 做异或操作
    
    return hashCode;
}

/**把hashCode转化成hashIndex*/
- (int)getHashIndexFromHashCode:(int)hashCode {

    int hashIndex = hashCode & (self.table.count - 1); // 3、异或 (self.table.count - 1)
    
    return hashIndex;
}


#pragma mark - 根据key的查找HashNode
/** 1、根据key查找root */
- (HashNode *)getRootFromKey:(id)key {
    int index = [self getHashIndexFromKey:key];
    HashNode *root = self.table[index];
    return root;
}

/** 2、根据key查找node */
- (HashNode *)getNodeFromKey:(id)key {
    
    HashNode *root = [self getRootFromKey:key];
    if([self isNullObject:root]) { // 根节点有可能为NSNull
        return nil;
    }
    
    HashNode *node = root;
    int cmp = 0;
    
    while (node != nil) {
        cmp = [self compareElement1:key element2:node.key hashCode1:[self getHashCodeFromKey:key] hashCode2:node.hashCode];
        if (cmp == 0) { // 当前节点
            return node;
        } else if (cmp > 0) {   // 右子树
            node = node.right;
        } else {    // 左子树
            node = node.left;
        }
    }
    return nil;
}

#pragma mark - 比较两个key的大小
/** 比较两个key的大小 - 存在问题 */
- (int)compareElement1:(id)element1 element2:(id)element2 hashCode1:(int)hashCode1 hashCode2:(int)hashCode2 {
    
    // 1、hashCode相同的2个key
//    int cmp = hashCode1 - hashCode2; // 存在问题：1、hashCode有可能是负数 2、两个hashCode想加有可能内存溢出变负值
//    if (cmp != 0) {
//        return cmp;
//    }
    
    // 1、hashCode相同的2个key
    int cmp = 0;
    if (hashCode1 > hashCode2) {
        cmp = 1;
        return cmp;
    }else if (hashCode1 < hashCode2) {
        cmp = -1;
        return cmp;
    }
    
    // 2、相同的1个key
    if ([element1 isEqual:element2]) {
        return 0;
    }
    
    // 3、hashCode相同的2个key
    cmp =  (int)[element1 compare:element2];
    return cmp;
}

/// 比较两个value是否相等
- (BOOL)valEquals:(id)v1 v2:(id)v2 {
    return v1 == nil ? v2 == nil : v1 == v2;
}

#pragma mark - table数组的扩容与缩容
/**动态数组扩容**/
- (void)ensureCapacity {
    int oldCapacity = (int)self.table.count;
    if (self.size/oldCapacity <= DEFAULT_LOAD_FACTOR) { // 1、装填因子<= 0.75 不扩容
        return;
    }
    
    // 新容量为旧容量的1.5倍
    NSMutableArray *oldTable = self.table; // 保存旧table
    int newCapacity = oldCapacity << 1; // 装填因子>0.75 扩容为原来的2倍
    self.table = [NSMutableArray arrayWithCapacity:newCapacity]; // 新table替换旧table
    for (int i = 0; i < newCapacity; i++) {
        // 默认用NSNull占位
        [self.table addObject:[NSNull null]];
    }
    
    // 旧值设回
    for (int i = 0; i < oldCapacity; i++) {
//        newElements[i] = self.table[i]; 扩容之后 hashIndex变了 不能这么做
        
        id obj = oldTable[i]; // 从旧table取数据
        
        if ([obj isEqual:[NSNull null]]) { // [NSNull null] 空树
            continue;
        }
        
        HashNode *root = (HashNode *)obj;
        Queue *queue = [[Queue alloc] init];
        [queue enQueue:root];

        while (!queue.isEmpty) {
            
            HashNode *node = [queue deQueue];
            // 把node从旧数组移动到新数组
//            [self moveNode:node]; //  调到下面 避免node重置后无法入队

            if (node.left != nil) {
                [queue enQueue:node.left];
            }

            if (node.right != nil) {
                [queue enQueue:node.right];
            }
            
            [self moveNode:node];
        }
    }

    NSLog(@"扩容为:%d",newCapacity);
}

- (void)moveNode:(HashNode *)newNode {
    
    // 0、重置
    newNode.parent = nil;
    newNode.left = nil;
    newNode.right = nil;
    newNode.color = HashNodeTypeRed;
    
    int index = [self getHashIndexFromHashCode:newNode.hashCode]; // 重新计算索引
    HashNode *root = self.table[index];
    
    // 1、添加第一个节点
    if ([self isNullObject:root]) {
        root = newNode;
        self.table[index] = root; // 将根节点放入到桶数组里
        
        // 5、新添加节点之后的处理
        [self afterPut:root];
        return;
    }
    
    // 2、添加的不是第一个节点
    // 此时哈希冲突（不同的key得哈希化后得到了相同的hashCode）
    HashNode *parent = root;
    HashNode *node = root;
    int cmp = 0;
    
    // 3、找到要添加位置的父节点
    while (![self isNullObject:node]) {
        cmp = [self compareElement1:newNode.key element2:node.key hashCode1:newNode.hashCode hashCode2:node.hashCode];
        parent = node; // 找到父节点
        
        if (cmp > 0) {  // 右节点
            node = node.right;
        } else if (cmp < 0) {   // 左节点
            node = node.left;
        } else {    // key相等 - 旧表里不肯能存在相等的元素 
//            node.key = key;
//            node.value = value;
//            node.hashCode = [self getHashCodeFromKey:key]; // 此处hashCode替不替换都可以 hashCode是相等的
            return;
        }
    }
    
    // 4、查看插入到父节点的哪个位置
    if (cmp > 0) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }

    newNode.parent = parent;
    
    /// 5、添加节点之后的处理
    [self afterPut:newNode];
}

/**动态数组缩容**/


#pragma mark - 子类重写 - 修复链表性质
/** 删除度为2的节点 node */
- (void)fixRemoveNode1:(HashNode *)node replace:(HashNode *)replaceNode {
    NSLog(@"子类重写 - 修复链表性质");
}

/** 删除度为1或0的节点 node */
- (void)fixRemoveNode2:(HashNode *)node {
    NSLog(@"子类重写 - 修复链表性质");
}


#pragma mark - 实现MJBinaryTreeInfo协议方法-打印TreeMap
- (id)root {
    return printRoot;
}

- (id)left:(HashNode *)node {
    if ([node isEqual:[NSNull null]]) {
        return nil;
    }

    return node.left;
}

- (id)right:(HashNode *)node {
    if ([node isEqual:[NSNull null]]) {
        return nil;
    }

    return node.right;
}

- (id)string:(HashNode *)node {
    if ([node isEqual:[NSNull null]]) {
        return nil;
    }

    return [NSString stringWithFormat:@"%@:%@",node.key, node.value];

//    if([self isRed:node]) {
//        return [NSString stringWithFormat:@"R_%@",node.key];
//    }else {
////        return [NSString stringWithFormat:@"B_%@",node.element];
//        return node.key;
//    }
}

#pragma mark - 打印HashMap
- (void)printHashMap {
    
    NSLog(@"HashMap打印开始");
        
    for (int i = 0 ; i < self.table.count ; i++) { // 遍历每一张红黑树
        
        id root = self.table[i];;
        
        if ([self isNullObject:root]) {
            
            NSLog(@"--------index:%d 空桶-------", i);

        }else {
            
            NSLog(@"--------index:%d Root -------", i);
            
            printRoot = (HashNode *)root;

            [MJBinaryTrees println:self];
            
        }
    }
    
    NSLog(@"HashMap打印结束");
}


@end
