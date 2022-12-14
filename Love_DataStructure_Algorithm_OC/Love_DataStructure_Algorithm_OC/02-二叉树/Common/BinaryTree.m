//
//  BinaryTree.m
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import "BinaryTree.h"
#import "Queue.h"
#import "Stack.h"

@implementation BinaryTree

#pragma mark - 二叉树接口
/**
 * 元素的数量
 */
- (NSUInteger)size {
    return _size;
}

/**
 * 是否为空
 */
- (bool)isEmpty {
    return _size == 0;
}

/**
 * 清空二叉树所有节点
 */
- (void)clear {
    self.size = 0;
    _root = nil;
}


#pragma mark - 二叉树遍历
#pragma mark 前序遍历(递归)
/// 前序遍历(递归)
- (void)preOrderCircleWithBlock:(MJTreeTraversalBlock)block {
    [self preOrderCircle:self.root block:block];
}

- (void)preOrderCircle:(TreeNode *)node block:(MJTreeTraversalBlock)block {
    if (node == nil) {
        return;
    }
    
//    NSLog(@"%@",node.description);
    if (block) {
        block(node.description);
    }
    
    [self preOrderCircle:node.left block:block];
    [self preOrderCircle:node.right block:block];
}

#pragma mark 中序遍历(递归)
/// 中序遍历(递归)
- (void)inOrderCircleWithBlock:(MJTreeTraversalBlock)block {
    [self inOrderCircle:self.root block:block];
}

- (void)inOrderCircle:(TreeNode *)node block:(MJTreeTraversalBlock)block {
    if (node == nil) {
        return;
    }
    
    [self inOrderCircle:node.left block:block];
    
    //    NSLog(@"%@",node.description);
        if (block) {
            block(node.description);
        }
    
    [self inOrderCircle:node.right block:block];
}

#pragma mark 后序遍历(递归)
/// 后序遍历(递归)
- (void)postOrderCircleWithBlock:(MJTreeTraversalBlock)block {
    [self postOrderCircle:self.root block:block];
}

- (void)postOrderCircle:(TreeNode *)node block:(MJTreeTraversalBlock)block {
    
    if (node == nil) {
        return;
    }
    
    [self postOrderCircle:node.left block:block];
    [self postOrderCircle:node.right block:block];
    
//    NSLog(@"%@",node.description);
    if (block) {
        block(node.description);
    }
}

#pragma mark 层序遍历(迭代)
/// 层序遍历
- (void)levelOrderWithBlock:(MJTreeTraversalBlock)block {
    if (self.root == nil) {
        return;
    }
    
    Queue *queue = [[Queue alloc] init];
    [queue enQueue:self.root];
    
    while (!queue.isEmpty) {
        TreeNode *node = [queue deQueue];
    //    NSLog(@"%@",node.description);
        if (block) {
            block(node.description);
        }
        
        if (node.left != nil) { // 左子节点入队
            [queue enQueue:node.left];
        }
        
        if (node.right != nil) {    // 右子节点入队
            [queue enQueue:node.right];
        }
    }
}

#pragma mark 前序遍历(迭代) - 层序遍历queue换成stack 右子树先入栈
/// 前序遍历(迭代)
- (void)preOrderWithBlock:(MJTreeTraversalBlock)block {
    if (self.root == nil) {
        return;
    }
    
    Stack *stack = [[Stack alloc] init];
    [stack push:self.root];
    
    while (!stack.isEmpty) {
        TreeNode *node = [stack pop];
    //    NSLog(@"%@",node.description);
        if (block) {
            block(node.description);
        }
        
        if (node.right != nil) {    // 右子树先入栈
            [stack push:node.right];
        }
        
        if (node.left != nil) {     // 左子节再入栈
            [stack push:node.left];
        }
    }
}

#pragma mark 中序遍历(迭代)
/// 中序遍历(迭代)
- (void)inOrderWithBlock:(MJTreeTraversalBlock)block {
    if (self.root == nil) {
        return;
    }
    
    // 1、创建栈
    TreeNode *node = self.root;
    Stack *stack = [[Stack alloc] init];
    
    while (!stack.isEmpty || node != nil) { // 注意：或
        // 1、一路往左走 直到最左位置 路上遇到的节点都入栈（包括根节点）
        while (node != nil) {
            [stack push:node];
            node = node.left;
        }
        
        // 2、不能再往左走了 弹出栈顶元素 赋值给node访问
        TreeNode *currNode = [stack pop];
//        NSLog(@"%@",currNode.description);
        if (block) {
            block(currNode.description);
        }
     
        // 3、查看一下currNode的右子树 如果右子树为nil 结束本次循环
        node = currNode.right;
    }
}

#pragma mark 后序遍历(迭代)
/// 后序遍历(迭代)
- (void)postOrderWithBlock:(MJTreeTraversalBlock)block {
    if (self.root == nil) {
        return;
    }
    
    // 1、将根节点入栈
    Stack *stack = [[Stack alloc] init];
    [stack push:self.root];
    TreeNode *currNode; // 用来记录上一次弹出栈的节点 （子节点已出栈 轮到父节点）
    
    while (!stack.isEmpty) {
        // 2、查看栈顶是否是叶子结点
        TreeNode *topNode = [stack top];
        
        if ([topNode isLeaf] || // 2.1、栈顶节点是否是椰子节点 或 上一次访问节点是否是栈顶节点的子节点 出栈 （子节点已出栈 轮到父节点）
            (currNode != nil && currNode.parent == topNode)) {
            // 3、出栈
            currNode = [stack pop];
//            NSLog(@"%@",currNode.description);
            if (block) {
                block(currNode.description);
            }
            
        }else { // 2.2、栈顶不是叶子结点 右子树先入栈 左子节再入栈
         
            if (topNode.right != nil) {    // 右子树先入栈
                [stack push:topNode.right];
            }
            
            if (topNode.left != nil) {     // 左子节再入栈
                [stack push:topNode.left];
            }
        }
    }
}

#pragma mark - 二叉树遍历应用
/// 1、计算二叉树的高度 - 递归实现
- (int)getHeight {
    return [self height:self.root];
}

- (int)height:(TreeNode *)node {
    if (node == nil) {
        return 0;
    }
    return 1 + MAX([self height:node.left], [self height:node.right]);
}

/// 2、计算二叉树的高度 - 迭代实现 - 层序遍历
- (int)getHeight2 {
    if (self.root == nil) {
        return 0;
    }
    
    int height = 0; // 树的高度
    int levelSize = 1;  // 存储着每一层的元素数量
    
    Queue *queue = [[Queue alloc] init];
    [queue enQueue:self.root];
    
    // 遍历队列
    while (!queue.isEmpty) {
        // 1、依次出栈
        TreeNode *node = queue.deQueue;
        levelSize--;
        
        // 2.1、左子树入栈
        if (node.left != nil) {
            [queue enQueue:node.left];
        }
        
        // 2.2、右子树入栈
        if (node.right != nil) {
            [queue enQueue:node.right];
        }
        
        if (levelSize == 0) {   // // 意味着即将要访问下一层
            levelSize = queue.size;
            height++;
        }
    }
    
    return height;
}

/// 是否为完全二叉树
- (BOOL)isComplteBinaryTree {
    if (self.root == nil) {
        return false;
    }
    
    Queue *queue = [[Queue alloc] init];
    [queue enQueue:self.root];
    
    BOOL leaf = false;  // 是否为叶子节点
    while (!queue.isEmpty) {
        
        TreeNode *node = [queue deQueue];
        //5、叶子结点 之后的节点都要是叶子结点
        if(leaf && !node.isLeaf) return false;
        
        // 1.1、node.left != nil && node.right != nil
        if (node.left != nil) { // 左子节点入队
            [queue enQueue:node.left];
        }else if (node.right != nil) {
            // 2、node.left == nil && node.right != nil
            return false;
        }
        
        // 1.2、node.left != nil && node.right != nil
        if (node.right != nil) {    // 右子节点入队
            [queue enQueue:node.right];
        }else { // 叶子结点 之后的节点都要是叶子结点
            // 3、node.left == nil && node.right == nil
            // 4、node.left != nil && node.right == nil
            leaf = true;
        }
    }

    return true;
}


#pragma mark - 翻转二叉树 -遍历法
// 递归法1-前序遍历
- (TreeNode *)invertTree1:(TreeNode *)root {
    if(!root) return nil;
    
    TreeNode *temp = root.left;
    root.left = root.right;
    root.right = temp;
    
    [self invertTree1:root.left];
    [self invertTree1:root.right];
    
    return root;
}

// 递归法2-中序遍历
- (TreeNode *)invertTree2:(TreeNode *)root {
    if(!root) return nil;
    
    [self invertTree2:root.left];
    
    TreeNode *temp = root.left;
    root.left = root.right;
    root.right = temp;
    
    // 注意 中序遍历：翻转之后的左子树才是翻转之前的右子树
    [self invertTree2:root.left];
    
    return root;
}

// 递归法3-后序遍历
- (TreeNode *)invertTree3:(TreeNode *)root {
    if(!root) return nil;
    
    [self invertTree3:root.left];
    [self invertTree3:root.right];
    
    TreeNode *temp = root.left;
    root.left = root.right;
    root.right = temp;
    
    return root;
}

// 迭代法4-层序遍历
- (TreeNode *)invertTree4:(TreeNode *)root {
    if(!root) return nil;
    
    Queue *queue = [[Queue alloc] init];
    [queue enQueue:root];
    
    while (!queue.isEmpty) {
        
        TreeNode *node = [queue deQueue];
        // 做翻转操作
        TreeNode *temp = node.left;
        node.left = node.right;
        node.right = temp;
        
        if(node.left != nil) {
            [queue enQueue:node.left];
        }
        
        if(node.right != nil) {
            [queue enQueue:node.right];
        }
    }
    
    return root;
}


#pragma mark - 中序遍历时前驱节点 和 后继节点
/// 找前驱节点
- (TreeNode *)prevNode:(TreeNode *)node {
    if (node == nil) {
        return nil;
    }
    
    /** 1.左子树不为空
        前驱节点在左子树当中（left.right.right.right....）
     */
    TreeNode *p = node.left;
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
    
    // 3.node.parent == null
    // 或node == node.parent.right
    return node.parent;
}

/// 找后继节点
- (TreeNode *)nextNode:(TreeNode *)node {
    if (node == nil) {
        return nil;
    }
    
    /** 1.右子树不为空
        前驱节点在左子树当中（node.right.left.left.left....）
     */
    TreeNode *p = node.right;
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
    
    // 3.node.parent == null
    // 或node == node.parent.left
    return node.parent;
}

#pragma mark - 二叉树相关概念
/**
 *二叉树的特点：
 *1、每个节点的度最大为2，最多拥有2颗子树。
 *2、左子树和右子树是有顺序的（二叉树是有序树）
 *3、即使某个节点只有一颗子树，也要区分左右子树
 *
 *
 *二叉树的性质：
 *1、非空二叉树的第i层，最多有2^(i-1)个节点（i >=1）
 *2、在高度为h的二叉树上，最多有2^h - 1个节点（h >=1）
 *3、对于任何一颗非空二叉树，如果叶子结点个数为n0，度为2的节点个数为n2，则有n0 = n2 + 1
 * 二叉树的节点总数：n = n0 + n1 + n2
 * 二叉树的边树 ： T = n1 + 2*n2 = n - 1 = n0 + n1 + n2 - 1
 *  n0 = n2 + 1
 */

/**
 *1、真二叉树：所有节点的度要么为0，要么为2
 *2、满二叉树：最后一层节点的度都为0，其他节点的度都为2
 *3、完全二叉树：叶子结点只会出现在最后2层，且最后一层的叶子结点都靠左对齐
 *3.1、完全二叉树从根节点到倒数第二层是一颗满二叉树
 *3.2、满二叉树一定是完全二叉树，完全二叉树不一定是满二叉树
 *
 *
 *完全二叉树性质
 *1、度为1的节点只有左子树
 *2、度为1的节点要么是1个，要么是0个
 *3、同样节点数量的二叉树，完全二叉树的高度最小
 *4、如果一颗完全二叉树有n个节点，那么其叶子结点个数n0 = floor((n + 1) / 2)，非叶子结点个数n1 + n2 = floor(n / 2)
 *5、如果一颗完全二叉树的高度为h (h>=1)，那么至少有2^(h - 1)个节点，至多有2^h - 1个节点（满二叉树）
 *  h = floor(log2n) + 1
 */

#pragma mark - 实现MJBinaryTreeInfo协议方法-打印二叉树
- (id)root {
    return _root;
}

- (id)left:(TreeNode *)node {
    return node.left;
}

- (id)right:(TreeNode *)node {
    return node.right;
}

- (id)string:(TreeNode *)node {
    return node.element;
}

@end
