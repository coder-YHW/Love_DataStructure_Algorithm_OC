//
//  BSTree.m
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import "BSTree.h"
#import "Queue.h"

@interface BSTree () {
    // 二叉搜索树-比较器-接口设计
    MJBSTComparatorBlock _comparatorBlock;
    id<MJBSTComparator> _comparator;
}

@end

@implementation BSTree

#pragma mark - 二叉搜索树 - 构造函数
+ (instancetype)tree {
    return [self treeWithComparator:nil];
}

+ (instancetype)treeWithComparatorBlock:(_Nullable MJBSTComparatorBlock)comparatorBlock {
    BSTree *bst = [[self alloc] init];
    bst->_comparatorBlock = comparatorBlock;
    return bst;
}

+ (instancetype)treeWithComparator:(id<MJBSTComparator>)comparator {
    BSTree *bst = [[self alloc] init];
    bst->_comparator = comparator;
    return bst;
}

/** 初始化 - TreeNode  - 子类可以重写*/
- (TreeNode *)createNode:(id)element parent:(nullable TreeNode *)parent {
    return [[TreeNode alloc] initWithElement:element parent:parent];
}

#pragma mark - 二叉搜索树 - 接口方法
/**
 * 添加元素为element的节点
 */
- (void)add:(id)element {
    if (!element) return;
    
    // 1、添加第一个节点- 根节点
    if (!self.root) {
//        self.root = [TreeNode alloc] initWithElement:element parent:nil];
        self.root = [self createNode:element parent:nil];
        self.size++;
        
        // 添加节点后平衡二叉搜索树 - 子类实现
        [self afterAdd:self.root];
        
        return;
    }
    
    // 2、添加的不是第一个节点 - 找到父节点
    TreeNode *parent = self.root;
    TreeNode *node = self.root;
    int cmp = 0;
    
    while (node) {
        cmp = [self compareElement1:element element2:node.element];
        parent = node; // 更新父节点
        
        if (cmp > 0) { // 右节点
            node = node.right;
        } else if (cmp < 0) { // 左节点
            node = node.left;
        } else { // 相等 - 覆盖
            node.element = element;
            return;
        }
    }
    
    // 3、根据找到的父节点-插入新节点
//    TreeNode *newNode = [[TreeNode alloc] initWithElement:element parent:parent];
    TreeNode *newNode = [self createNode:element parent:parent];
    if (cmp > 0) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }
    // 索引++
    self.size++;
    
    // 添加节点后平衡二叉搜索树 - 子类实现
    [self afterAdd:newNode];
}

/**
 * 删除元素为element的节点
 */
- (void)removeElement:(id)element {
    [self removeNode:[self getNodeFromElement:element]];
}

/**
 * 删除节点为node的节点
 */
- (void)removeNode:(TreeNode *)node {
    if (node == nil) {
        return;
    }
    
    // 1、node的度为2 - 它的前驱节点或后继节点 只能是度为0或1的节点
    if (node.hasTwoChildren) {
        // 1.1、找到后继节点
        TreeNode *nextNode = [self nextNode:node];
        // 1.2、用后继节点的值覆盖度为2的节点
        node.element = nextNode.element;
        // 1.3、删除后继节点 - 用后继节点覆盖node 后续再删除node
        node = nextNode;
    }
    
    // 删除node节点（后面node的度必然是0或1）
    TreeNode *replcaeNode = node.left != nil ? node.left : node.right;
    
    if(replcaeNode != nil) { // 2、node的度为1 (更改子节点的parent➕更改父节点的左子树或右子树为replcaeNode)
        
        // 2.1、更改字节点的parent
        replcaeNode.parent = node.parent;
        
        if (node.parent == nil) { // 2.2、node是根结点
            self.root = replcaeNode;
        }else if (node == node.parent.left) { // 2.3、node是左子树
            node.parent.left = replcaeNode;
        }else if (node == node.parent.right) { // 2.4、node是右子树
            node.parent.right = replcaeNode;
        }
        
        // size --
        self.size--;
        
        // 删除节点后平衡二叉搜索树 - 子类实现
        [self afterRemove:replcaeNode];
        
    }else { // 3、node的度为0 （更改父节点的左子树或右子树为replcaeNode == nil）
        
        // replcaeNode == nil
        if (node.parent == nil) { // 3.1、node是根结点
            self.root = nil;
        }else if (node == node.parent.left) { // 3.2、node是左子树
            node.parent.left = nil;
        }else if (node == node.parent.right) { // 3.3、node是右子树
            node.parent.right = nil;
        }
        
        // size --
        self.size--;
        
        // 删除节点后平衡二叉搜索树 - 子类实现
        [self afterRemove:node];
    }

}

/**
 * 返回元素为element的节点
 */
- (TreeNode *)getNodeFromElement:(id)element {
    TreeNode *node = self.root;
    int cmp = 0;
    
    while (node != nil) {
        cmp = [self compareElement1:element element2:node.element];
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

/**
 * 是否包含某个元素
 */
- (bool)contains:(id)element {
    return [self getNodeFromElement:element];
}


#pragma mark - 比较器
/** 比较两元素的大小 */
- (int)compareElement1:(id)element1 element2:(id)element2 {
    return _comparatorBlock ? _comparatorBlock(element1, element2) :
    (_comparator ? (int)[_comparator compareElement1:element1 another:element2] : (int)[element1 compare:element2]);
}


#pragma mark - 平衡二叉搜索树 - 子类实现
/** 添加节点后平衡二叉搜索树 - 子类实现 */
- (void)afterAdd:(TreeNode *)node {
    NSLog(@"afterAdd : 平衡二叉搜索树 - 子类实现");
}

/** 删除节点后平衡二叉搜索树  - 子类实现 */
- (void)afterRemove:(TreeNode *)node {
    NSLog(@"afterRemove : 平衡二叉搜索树 - 子类实现");
}

@end
