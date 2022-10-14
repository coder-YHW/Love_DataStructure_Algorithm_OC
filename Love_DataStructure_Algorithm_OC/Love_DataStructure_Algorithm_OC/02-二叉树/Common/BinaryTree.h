//
//  BinaryTree.h
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

/** 实现打印二叉树：
 * 1、遵守MJBinaryTreeInfo协议
 * 2、实现MJBinaryTreeInfo协议方法
*/
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

/// 二叉树
@interface BinaryTree : NSObject <MJBinaryTreeInfo>
 
#pragma mark - 二叉树通用属性
/** root*/
@property (nonatomic,strong,nullable) TreeNode *root;
/** size*/
@property (nonatomic,assign) NSUInteger size;

#pragma mark - 二叉树通用接口
/**
 * 元素的数量
 */
- (NSUInteger)size;

/**
 * 是否为空
 */
- (bool)isEmpty;

/**
 * 清空所有节点
 */
- (void)clear;


#pragma mark - 二叉树遍历
/** 前序遍历 */
- (void)preOrder;

/** 中序遍历 */
- (void)inOrder;

/** 后序遍历 */
- (void)postOrder;

/** 层序遍历 */
- (void)levelOrder;

#pragma mark - 二叉树遍历应用
/// 计算二叉树的高度 - 递归实现
- (int)getHeight;

/// 计算二叉树的高度 - 迭代实现
- (int)getHeight2;

/// 是否为完全二叉树
- (BOOL)isComplteBinaryTree;

#pragma mark - 翻转二叉树 -遍历法
// 递归法1-前序遍历
- (TreeNode *)invertTree1:(TreeNode *)root;
// 递归法2-中序遍历
- (TreeNode *)invertTree2:(TreeNode *)root;
// 递归法3-后序遍历
- (TreeNode *)invertTree3:(TreeNode *)root;
// 迭代法4-层序遍历
- (TreeNode *)invertTree4:(TreeNode *)root;

#pragma mark - 前驱节点 和 后继节点
/** 找前驱节点 */
- (TreeNode *)prevNode:(TreeNode *)node;

/** 找后继节点 */
- (TreeNode *)nextNode:(TreeNode *)node;

@end

NS_ASSUME_NONNULL_END
