//
//  AVLTree.m
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "AVLTree.h"
#import "AVLNode.h"

@implementation AVLTree

#pragma mark - 初始化AVLNode
/** 初始化 - TreeNode  - AVLTree子类重写 */
- (AVLNode *)createNode:(id)element parent:(nullable TreeNode *)parent {
    return [[AVLNode alloc] initWithElement:element parent:parent];
}

#pragma mark - 平衡二叉搜索树 -（AVLTree重写）子类实现
/** 添加节点后平衡二叉搜索树 -  AVLTree子类重写 */
- (void)afterAdd:(TreeNode *)node {
//    NSLog(@"afterAdd : 平衡二叉搜索树 - 子类实现");
    
    while ((node = node.parent) != nil) { // 0、沿着父节点一直往上 寻找最近的不平衡节点
        
        if ([self isBalanced:(AVLNode *)node]) { // 1、是平衡二叉搜索树
            // 1.1 更新高度
            [self updateHeight:(AVLNode *)node];
            
        }else { // 2、不是平衡二叉搜索树
            // 2.1 恢复平衡
            [self rebalance2:(AVLNode *)node];
            // 整颗树恢复平衡
            break; // 退出while循环
        }
    }
    

}

/** 删除节点后平衡二叉搜索树  -  AVLTree子类重写 */
- (void)afterRemove:(TreeNode *)node {
//    NSLog(@"afterRemove : 平衡二叉搜索树 - 子类实现");
    
    while ((node = node.parent) != nil) { // 0、沿着父节点一直往上 寻找最近的不平衡节点
        
        if ([self isBalanced:(AVLNode *)node]) { // 1、是平衡二叉搜索树
            // 1.1 更新高度
            [self updateHeight:(AVLNode *)node];
            
        }else { // 2、不是平衡二叉搜索树
            // 2.1 恢复平衡 - 不能break
            [self rebalance:(AVLNode *)node];

        }
    }
}

/** 是否是平衡二叉搜索树 */
- (BOOL)isBalanced:(AVLNode *)node {
    return abs(node.balanceFactor) <= 1;
}

/** 更新子树高度 */
- (void)updateHeight:(AVLNode *)node {
    [node updateHeight];
}

#pragma mark - 恢复平衡 - 法一
/**
 恢复平衡 - 法一
 @param grand 高度最低的那个不平衡节点
 */
- (void)rebalance:(AVLNode *)grand {
    
    AVLNode *parent = (AVLNode *)(grand.tallerChild);
    TreeNode *node = parent.tallerChild;
    
    if (parent.isLeftChild) {   // L
        if (node.isLeftChild) { // LL
            [self rotateRight:grand];
        } else {    // LR
            [self rotateLeft:parent];
            [self rotateRight:grand];
        }
    } else {    // R
        if (node.isLeftChild) { // RL
            [self rotateRight:parent];
            [self rotateLeft:grand];
        } else {    // RR
            [self rotateLeft:grand];
        }
    }
}

/** 重写父类方法 - 更新节点高度 */
- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child {
    
    [super afterRotate:grand parent:parent child:child];
    
    // 更新高度 顺序不能乱，先子后父 - （下面代码是旋转之后的grand，parent父子关系有变化）
    [self updateHeight:(AVLNode *)grand];
    [self updateHeight:(AVLNode *)parent];
}

#pragma mark - 恢复平衡 - 法二
/**
 恢复平衡
 @param grand 高度最低的那个不平衡节点
 */
- (void)rebalance2:(AVLNode *)grand {
    
    AVLNode *parent = (AVLNode *)grand.tallerChild;
    AVLNode *node = (AVLNode *)parent.tallerChild;
    
    if (parent.isLeftChild) {   // L
        if (node.isLeftChild) { // LL
            [self rotate:grand a:node.left b:node c:node.right d:parent e:parent.right f:grand g:grand.right];
        } else {    // LR
            [self rotate:grand a:parent.left b:parent c:node.left d:node e:node.right f:grand g:grand.right];
        }
    } else {    // R
        if (node.isLeftChild) { // RL
            [self rotate:grand a:grand.left b:grand c:node.left d:node e:node.right f:parent g:parent.right];
        } else {    // RR
            [self rotate:grand a:grand.left b:grand c:parent.left d:parent e:node.left f:node g:node.right];
        }
    }
}

/// 旋转操作
- (void)rotate:(TreeNode *)r    // 子树的根节点
             a:(TreeNode *)a b:(TreeNode *)b c:(TreeNode *)c
             d:(TreeNode *)d
             e:(TreeNode *)e f:(TreeNode *)f g:(TreeNode *)g {
    
    [super rotate:r a:a b:b c:c d:d e:e f:f g:g];
    
    // 更新高度 - 顺序不能乱，先子后父
    [self updateHeight:(AVLNode *)b];
    [self updateHeight:(AVLNode *)f];
    [self updateHeight:(AVLNode *)d];
}


@end
