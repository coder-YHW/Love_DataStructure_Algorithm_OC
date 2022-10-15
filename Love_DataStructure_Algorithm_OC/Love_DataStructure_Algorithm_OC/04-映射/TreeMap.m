//
//  TreeMap.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "TreeMap.h"
#import "Queue.h"

#pragma mark - TreeMap

@interface TreeMap(){
    // 比较器-接口设计
    MJMapComparatorBlock _comparatorBlock;
    id<MJMapComparator> _comparator;
}

/** size*/
@property (nonatomic,assign) int size;
/** root */
@property (nonatomic,strong) MapNode *root;

@end

@implementation TreeMap

#pragma mark - TreeMap - 构造函数
+ (instancetype)map {
    return [self mapWithComparator:nil];
}

+ (instancetype)mapWithComparatorBlock:(_Nullable MJMapComparatorBlock)comparatorBlock {
    TreeMap *treeMap = [[self alloc] init];
    treeMap->_comparatorBlock = comparatorBlock;
    return treeMap;
}

+ (instancetype)mapWithComparator:(id<MJMapComparator>)comparator {
    TreeMap *treeMap = [[self alloc] init];
    treeMap->_comparator = comparator;
    return treeMap;
}


#pragma mark - override

/**元素个数*/
- (int)size {
    return _size;
}

/**是否为空*/
- (BOOL)isEmpty {
    return self.size == 0;
}

/**清除所有元素*/
- (void)clear {
    self.root = nil;
    self.size = 0;
}

/** 根据key查找node */
- (MapNode *)getNodeFromKey:(id)key {
    MapNode *node = _root;
    int cmp = 0;
    while (node != nil) {
        cmp = [self compareElement1:key element2:node.key];
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

/**根据key查询value*/
- (id)get:(id)key {
    MapNode *node = [self getNodeFromKey:key];
    return node != nil ? node.value : nil;
}

/**是否包含Key*/
- (BOOL)containsKey:(id)key {
    return [self getNodeFromKey:key] != nil;
}

/**是否包含Value - 层序遍历*/
- (BOOL)containsValue:(id)value {
    if (_root == nil) {
        return false;
    }
    
    Queue *queue = [[Queue alloc] init]; // 队列
    [queue enQueue:_root];
    
    while (!queue.isEmpty) {
        
        MapNode *node = [queue deQueue];
        if ([self valEquals:value v2:node.value]) {
            return YES;
        }
        
        if (node.left != nil) {
            [queue enQueue:node.left];
        }
        
        if (node.right != nil) {
            [queue enQueue:node.right];
        }
    }
    
    return false;
}

/**层序遍历*/
- (void)traversalWithBlock:(MJMapTraversalBlock)block {
    
    if (_root == nil) {
        return;
    }
    
    Queue *queue = [[Queue alloc] init];
    [queue enQueue:_root];
    
    while (!queue.isEmpty) {
        MapNode *node = [queue deQueue];
//        NSLog(@"%@_%@",node.key, node.value);
        // MJMapTraversalBlock
        if (block) {
            block(node.key, node.value);
        }
        
        if (node.left != nil) { // 左子节点入队
            [queue enQueue:node.left];
        }
        
        if (node.right != nil) {    // 右子节点入队
            [queue enQueue:node.right];
        }
    }
}

- (BOOL)valEquals:(id)v1 v2:(id)v2 {
    return v1 == nil ? v2 == nil : v1 == v2;
}

#pragma mark - 添加元素
/**添加元素*/
- (void)put:(id)key value:(id)value {
    if ([self keyNotNullCheck:key]) {
        return;
    }
    
    // 1、添加第一个节点
    if (_root == nil) {
        _root = [[MapNode alloc] initWithKey:key value:value parent:nil];
        _size++;
        
        // 5、新添加节点之后的处理
        [self afterPut:_root];
        
        return;
    }
    
    // 2、添加的不是第一个节点
    MapNode *parent = self.root;
    MapNode *node = self.root;
    int cmp = 0;
    
    // 3、找到要添加位置的父节点
    while (node != nil) {
        cmp = [self compareElement1:key element2:node.key];
        parent = node; // 找到父节点
        
        if (cmp > 0) {  // 右节点
            node = node.right;
        } else if (cmp < 0) {   // 左节点
            node = node.left;
        } else {    // 相等 - 覆盖
            node.key = key;
            node.value = value;
            return;
        }
    }
    
    // 4、查看插入到父节点的哪个位置
    MapNode *newNode = [[MapNode alloc] initWithKey:key value:value parent:parent];
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
- (void)afterPut:(MapNode *)node {
//    NSLog(@"afterAdd : 平衡二叉搜索树 - 子类实现");
    
    MapNode *parent = node.parent;
    
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
    MapNode *uncle = parent.sibling;
    // 祖父节点
    MapNode *grand = parent.parent;
    
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
- (void)removeNode:(MapNode *)node {
    if (node == nil) {
        return;
    }
    
    self.size--;
    
    if (node.hasTwoChildren) {  // 度为2的节点
        // 找到后继节点
        MapNode *nextNode = [self nextNode:node];
        // 用后继节点的值覆盖度为2的节点的值
        node.key = nextNode.key;
        node.value = nextNode.value;
        
        // 删除后继节点
        node = nextNode;
    }
    
    // 删除node节点(node的度必然是1或者0)
    MapNode *replacement = node.left != nil ? node.left : node.right;
    
    if (replacement != nil) {   // 1.node是度为1的节点
        // 更改parent
        replacement.parent = node.parent;
        // 更改parent的left,right的指向
        if (node.parent == nil) {   // node是度为1的节点并且是根节点
            self.root = replacement;
        } else if (node == node.parent.left) {  // 左子节点
            node.parent.left = replacement;
        } else {    // node == node.parent.right
            node.parent.right = replacement;
        }
    } else if (node.parent == nil) {    // 2.node是叶子节点并且是根节点
        self.root = nil;
    } else {    // 3.node是叶子节点,但不是根节点
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {    // node == node.parent.right
            node.parent.right = nil;
        }
    }
    
    /// 删除节点之后的处理
    [self afterRemove:node];
}

#pragma mark - 比较器
- (BOOL)keyNotNullCheck:(id)key {
    return key == nil;
}

/** 比较两元素的大小 */
- (int)compareElement1:(id)element1 element2:(id)element2 {
    return _comparatorBlock ? _comparatorBlock(element1, element2) :
    (_comparator ? (int)[_comparator compareElement1:element1 another:element2] : (int)[element1 compare:element2]);
}

/**删除之后再平衡**/
- (void)afterRemove:(MapNode *)node {
//    NSLog(@"afterRemove : 平衡二叉搜索树 - 子类实现");
    
//    // 1、如果删除的节点是红色 直接删除-不做任何调整 （合并到下面去判断）
//    if ([self isRed:node]) return; // 直接删除-不做任何调整
    
    // 1、如果删除的节点是红色 直接删除-不做任何调整
    // 2、如果删除的黑色节点有2个Red子节点，会用前驱或者后继节点去替代删除（不用考虑这种情况）
    
    // 注意：当删除的节点度为1时，afterRemove传进来的不是node，而是replcaeNode（红黑树要求 不影响AVL树）
    // 3、如果删除的黑色节点只有1个Red子节点，用以取代删除节点的子节点replcaeNode是红色               只需要把replcaeNode染黑就可以保持红黑树性质
    if ([self isRed:node]) { // 如果删除的节点是红色 || 用以取代删除节点的子节点replcaeNode是红色
        [self black:node];
        return;
    }
    
    MapNode *parent = node.parent;
    // 4、删除的是根节点
    if (parent == nil) {
        return;
    }
    
    // 5、删除的是黑色叶子节点[下溢]
    // 判断被删除的node是左还是右
    BOOL isLeft = parent.left == nil || node.isLeftChild; // 注意这2种情况
    MapNode *sibling = isLeft ? parent.right : parent.left;
    
    if (isLeft) { // 5.1、被删除的节点在左边,兄弟节点在右边
        
        if ([self isRed:sibling]) { // 5.1.1、红兄弟节点 -（把红兄弟的黑色子节点 通过旋转转成兄弟节点是黑色的情况来处理）
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            
            // 更换兄弟
            sibling = parent.right;
        }
        
        // 5.1.2、兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 5.1.2.1、黑兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            
            if (parentBlack) { // 5.1.2.2、如果parent为Black，会导致parent下溢
                [self afterRemove:parent];
            }
            
        } else {    // 5.1.2.3、黑兄弟节点至少有一个红色子节点,向兄弟节点借红色子节点
            // 黑兄弟节点的左边是黑色,兄弟要先旋转
            if ([self isBlack:sibling.right]) { // sibling-RL
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            
            // sibling-RR
            [self color:sibling color:[self colorOf:parent]]; // 旋转之后的中心节点继承parent的颜色
            [self black:sibling.right]; // 旋转之后的左右节点染为黑色
            [self black:parent]; // 旋转之后的左右节点染为黑色
            [self rotateLeft:parent];
        }
    } else {    // 5.2、被删除的节点在右边,兄弟节点在左边
        
        if ([self isRed:sibling]) { // 5.2.1、红兄弟节点 -（把红兄弟的黑色子节点 通过旋转转成兄弟节点是黑色的情况来处理）
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            
            // 更换兄弟
            sibling = parent.left;
        }
        
        // 5.2.2、黑兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 3.2.2.1、黑兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            
            if (parentBlack) { // 5.2.2.2、如果parent为Black，会导致parent下溢
                [self afterRemove:parent];
            }
            
        } else {    // 5.2.2.3、黑兄弟节点至少有一个红色子节点,向兄弟节点借红色子节点
            // 黑兄弟节点的左边是黑色,兄弟要先旋转
            if ([self isBlack:sibling.left]) {  // sibling-LR
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            
            // sibling-LL
            [self color:sibling color:[self colorOf:parent]]; // 旋转之后的中心节点继承parent的颜色
            [self black:sibling.left]; // 旋转之后的左右节点染为黑色
            [self black:parent]; // 旋转之后的左右节点染为黑色
            [self rotateRight:parent];
        }
    }
    
}

#pragma mark - 平衡红黑树-旋转
/** 左旋转 grand - 爷爷节点 */
- (void)rotateLeft:(MapNode *)grand {
    
    MapNode *parent = grand.right;
    MapNode *node = parent.left;
    
    // 1、移动parent.left节点
    grand.right = parent.left;
    parent.left = grand;
    
    // 2、依次更新parent、node、grand的grand
    [self afterRotate:grand parent:parent child:node];
}

/** 右旋转 */
- (void)rotateRight:(MapNode *)grand {
    
    MapNode *parent = grand.left;
    MapNode *node = parent.right;
    
    // 1、移动parent.right节点
    grand.left = parent.right;
    parent.right = grand;
    
    // 2、依次更新parent、node、grand的grand
    
    [self afterRotate:grand parent:parent child:node];
}

/** 按照顺序更新节点的parent： 1、parent.parent  2、child.parent  3、grand.parent*/
- (void)afterRotate:(MapNode *)grand parent:(MapNode *)parent child:(MapNode *)node {
    // 1.1、让parent成为子树的根节点
    parent.parent = grand.parent;
    
    // 1.2、让grand.parent指向parent
    if (grand.isLeftChild) { // grand是左子树
        grand.parent.left = parent;
    } else if (grand.isRightChild) { // grand是右子树
        grand.parent.right = parent;
    } else {    // grand是root节点
        self.root = parent;
    }
    
    // 2、更新node的grand
    if (node != nil) {
        node.parent = grand;
    }
    
    // 3、更新grand的parent
    grand.parent = parent;
}

#pragma mark - 平衡红黑树-染色
- (MapNode *)color:(MapNode *)node color:(MapNodeType)MapNodeType {
    if (node == nil) {
        return node;
    }
    
    node.color = MapNodeType;
    return node;
}

- (MapNode *)red:(MapNode *)node {
    return [self color:node color:MapNodeTypeRed];
}

- (MapNode *)black:(MapNode *)node {
    return [self color:node color:MapNodeTypeBlack];
}

- (MapNodeType)colorOf:(MapNode *)node {
    return node == nil ? MapNodeTypeBlack : node.color;
}

- (BOOL)isBlack:(MapNode *)node {
    return [self colorOf:node] == MapNodeTypeBlack;
}

- (BOOL)isRed:(MapNode *)node {
    return [self colorOf:node] == MapNodeTypeRed;
}

#pragma mark - 前驱节点 和 后继节点
/** 找前驱节点 */
- (MapNode *)prevNode:(MapNode *)node {
    if (node == nil) {
        return nil;
    }
    
    /** 1.左子树不为空
     前驱节点在左子树当中（left.right.right.right....）
     */
    MapNode *p = node.left;
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
- (MapNode *)nextNode:(MapNode *)node {
    if (node == nil) {
        return nil;
    }
    
    /** 1.右子树不为空
     前驱节点在左子树当中（node.right.left.left.left....）
     */
    MapNode *p = node.right;
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


#pragma mark - 实现MJBinaryTreeInfo协议方法-打印TreeMap
- (id)root {
    return _root;
}

- (id)left:(MapNode *)node {
    return node.left;
}

- (id)right:(MapNode *)node {
    return node.right;
}

- (id)string:(MapNode *)node {
    
//    return [NSString stringWithFormat:@"%@:%@",node.key, node.value];
    
    if([self isRed:node]) {
        return [NSString stringWithFormat:@"R_%@:%@",node.key, node.value];
    }else {
        return [NSString stringWithFormat:@"%@:%@",node.key, node.value];
    }
}

@end
