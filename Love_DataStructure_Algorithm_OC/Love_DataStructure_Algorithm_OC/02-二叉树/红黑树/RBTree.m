//
//  RBTree.m
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "RBTree.h"
#import "RBNode.h"

@implementation RBTree

#pragma mark - 初始化RBNode
/** 初始化 - TreeNode  - RBTree子类重写 */
- (RBNode *)createNode:(id)element parent:(nullable TreeNode *)parent {
    return [[RBNode alloc] initWithElement:element parent:parent];
}

#pragma mark - 平衡二叉搜索树 -（RBTree重写）子类实现
/** 添加节点后平衡二叉搜索树 -  RBTree子类重写 */
- (void)afterAdd:(TreeNode *)node {
//    NSLog(@"afterAdd : 平衡二叉搜索树 - 子类实现");
    
    TreeNode *parent = node.parent;
    
    // 1、添加的是根节点,或者上溢到达了根节点
    // 1.1、将自己染黑
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
    TreeNode *uncle = parent.sibling;
    // 祖父节点
    TreeNode *grand = parent.parent;
    
    // 3、父节点是红色&&叔父节点是红色[B树节点上溢] - （红黑红-往红节点上添加）4种情况
    if ([self isRed:uncle]) {
        // 3.1、将grand染红，父节点、叔父节点都染黑
        [self black:parent];
        [self black:uncle];
        // 3.2、等价于 - 将祖父节点当做是新添加的节点
        [self red:grand];
        [self afterAdd:grand];
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

/** 删除节点后平衡二叉搜索树  -  RBTree子类重写 */
- (void)afterRemove:(TreeNode *)node {
//    NSLog(@"afterRemove : 平衡二叉搜索树 - 子类实现");
    
//    // 1、如果删除的节点是红色 直接删除-不做任何调整 （合并到下面去判断）
//    if ([self isRed:node]) return; // 直接删除-不做任何调整
    
    // 1、如果删除的节点是红色 直接删除-不做任何调整
    // 2、如果删除的黑色节点有2个Red子节点，会用前驱或者后继节点去替代删除（不用考虑这种情况）
    
    // 当删除的节点度为1时，afterRemove传进来的不是node，而是replcaeNode（红黑树要求 不影响AVL树）
    // 3、如果删除的黑色节点只有1个Red子节点，用以取代删除节点的子节点replcaeNode是红色               只需要把replcaeNode染黑就可以保持红黑树性质
    if ([self isRed:node]) { // 如果删除的节点是红色 || 用以取代删除节点的子节点replcaeNode是红色
        [self black:node];
        return;
    }
    
    TreeNode *parent = node.parent;
    // 4、删除的是根节点
    if (parent == nil) {
        return;
    }
    
    // 5、删除的是黑色叶子节点[下溢]
    // 判断被删除的node是左还是右
    BOOL left = parent.left == nil || node.isLeftChild;
    TreeNode *sibling = left ? parent.right : parent.left;
    
    if (left) { // 5.1、被删除的节点在左边,兄弟节点在右边
        
        if ([self isRed:sibling]) { // 5.1.1、兄弟节点是红色 -（转成兄弟节点是黑色情况再处理）
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            
            // 更换兄弟
            sibling = parent.right;
        }
        
        // 5.1.2、兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 5.1.2.1、兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            
            if (parentBlack) { // 5.1.2.2、如果parent为Black，会导致parent下溢
                [self afterRemove:parent];
            }
            
        } else {    // 5.1.2.3、兄弟节点至少有一个红色子节点,向兄弟节点借元素
            // 兄弟节点的左边是黑色,兄弟要先旋转
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
        
        if ([self isRed:sibling]) { // 5.2.1、兄弟节点是红色 -（转成兄弟节点是黑色情况再处理）
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            
            // 更换兄弟
            sibling = parent.left;
        }
        
        // 5.2.2、兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 3.2.2.1、兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            
            if (parentBlack) { // 5.2.2.2、如果parent为Black，会导致parent下溢
                [self afterRemove:parent];
            }
            
        } else {    // 5.2.2.3、兄弟节点至少有一个红色子节点,向兄弟节点借元素
            // 兄弟节点的左边是黑色,兄弟要先旋转
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


#pragma mark - 染色
/**给红黑树节点染色**/
- (TreeNode *)color:(TreeNode *)node color:(RBTreeNodeType)color {
    if (!node) {
        return node;
    }
    ((RBNode *)node).color = color;
    return node;
}

/**将红黑树节点染成红色**/
- (TreeNode *)red:(TreeNode *)node {
    return [self color:node color:RBTreeNodeTypeRed];
}

/**将红黑树节点染成黑色**/
- (TreeNode *)black:(TreeNode *)node {
    return [self color:node color:RBTreeNodeTypeBlack];
}

/**返回红黑树节点色值**/
- (RBTreeNodeType)colorOf:(TreeNode *)node {
    return node == nil ?  RBTreeNodeTypeBlack : ((RBNode *)node).color;
}

/**红黑树节点是否是红色**/
- (BOOL)isRed:(TreeNode *)node {
    return [self colorOf:node] == RBTreeNodeTypeRed;
}

/**红黑树节点是否是黑色**/
- (BOOL)isBlack:(TreeNode *)node {
    return [self colorOf:node] == RBTreeNodeTypeBlack;
}

#pragma mark - 实现MJBinaryTreeInfo协议方法-打印二叉树
- (id)string:(TreeNode *)node {
    if([self isRed:node]) {
        return [NSString stringWithFormat:@"R_%@",node.element];
    }else {
//        return [NSString stringWithFormat:@"B_%@",node.element];
        return node.element;
    }
}

@end
