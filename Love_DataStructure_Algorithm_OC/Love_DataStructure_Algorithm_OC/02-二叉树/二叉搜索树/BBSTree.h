//
//  BBSTree.h
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "BSTree.h"

@class TreeNode;

NS_ASSUME_NONNULL_BEGIN

/// 平衡二叉搜索树
@interface BBSTree : BSTree

#pragma mark - 平衡二叉搜索树-方法一
/** 左旋转 grand - 爷爷节点 */
- (void)rotateLeft:(TreeNode *)grand;

/** 右旋转 */
- (void)rotateRight:(TreeNode *)grand;

/** 按照顺序更新节点的parent： 1、parent.parent  2、node.parent  3、grand.parent*/
- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)node;

#pragma mark - 平衡二叉搜索树-方法二
/** 统一所有旋转操作*/
- (void)rotate:(TreeNode *)r    // 旋转前子树的根节点
             a:(TreeNode *)a b:(TreeNode *)b c:(TreeNode *)c
             d:(TreeNode *)d    // 旋转后子树的根节点
             e:(TreeNode *)e f:(TreeNode *)f g:(TreeNode *)g;

@end

NS_ASSUME_NONNULL_END
