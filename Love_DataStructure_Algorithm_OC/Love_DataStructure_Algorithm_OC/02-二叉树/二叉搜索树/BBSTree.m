//
//  BBSTree.m
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "BBSTree.h"
#import "AVLNode.h"

@implementation BBSTree

#pragma mark - 平衡二叉搜索树-方法一 - 依次更grand、parent的高度
/** 左旋转 grand - 爷爷节点 */
- (void)rotateLeft:(TreeNode *)grand {
    
    // 1、// 1、找到parent和child
    TreeNode *parent = grand.right;
    TreeNode *child = parent.left;
    
    // 2、旋转grand、parent和child - 改动2根线
    grand.right = parent.left;
    parent.left = grand;
    
    // 3、依次更新parent、child、grand的parent
    [self afterRotate:grand parent:parent child:child];
}

/** 右旋转 */
- (void)rotateRight:(TreeNode *)grand {
    
    TreeNode *parent = grand.left;
    TreeNode *child = parent.right;
    
    // 1、移动parent.right节点
    grand.left = parent.right;
    parent.right = grand;
    
    // 2、依次更新parent、child、grand的grand
    [self afterRotate:grand parent:parent child:child];
}

/** 按照顺序更新节点的parent： 1、parent.parent  2、child.parent  3、grand.parent*/
- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child {
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
    
    // 2、更新child的grand - child有可能不存在
    if (child != nil) {
        child.parent = grand;
    }
    
    // 3、更新grand的parent
    grand.parent = parent;
}


#pragma mark - 平衡二叉搜索树-方法二 - 依次更新b、f、d的高度
/** 统一所有旋转操作*/
- (void)rotate:(TreeNode *)r    // 旋转前子树的根节点
             a:(TreeNode *)a b:(TreeNode *)b c:(TreeNode *)c
             d:(TreeNode *)d    // 旋转后子树的根节点
             e:(TreeNode *)e f:(TreeNode *)f g:(TreeNode *)g {
    
    // 1.1、让d成为这棵子树的根节点
    d.parent = r.parent;
    // 1.2、让r.parent指向d
    if (r.isLeftChild) {
        r.parent.left = d;
    } else if (r.isRightChild) {
        r.parent.right = d;
    } else {
        self.root = d;
    }
    
    // 2、a-b-c
    b.left = a;
    if (a != nil) {
        a.parent = b;
    }
    b.right = c;
    if (c != nil) {
        c.parent = b;
    }
    
    // 3、e-f-g
    f.left = e;
    if (e != nil) {
        e.parent = f;
    }
    f.right = g;
    if (g != nil) {
        g.parent = f;
    }
    
    // 4、b-d-f
    d.left = b;
    d.right = f;
    b.parent = d;
    f.parent = d;
}

@end
