//
//  BSTree.h
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import "BinaryTree.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 二叉搜索树-比较器-接口设计
// 1、协议 - 协议
@protocol MJBSTComparator
@required
- (int)compareElement1:(id)e1 another:(id)e2;
@end

// 2、Block - 比较器
typedef int (^MJBSTComparatorBlock)(id e1, id e2);

#pragma mark - 二叉搜索树 - 构造函数
/// 二叉搜索树
@interface BSTree : BinaryTree

/** 构造函数 */
+ (instancetype)tree;
+ (instancetype)treeWithComparatorBlock:(_Nullable MJBSTComparatorBlock)comparator;
+ (instancetype)treeWithComparator:(_Nullable id<MJBSTComparator>)comparator;

/** 初始化 - TreeNode  - 子类可以重写*/
- (TreeNode *)createNode:(id)element parent:(nullable TreeNode *)parent;

#pragma mark - 二叉搜索树 - 接口方法
/** 添加元素为element的节点*/
- (void)add:(id)element;

/** 删除元素为element的节点*/
- (void)removeElement:(id)element;

/** 是否包含某个元素*/
- (bool)contains:(id)element;


#pragma mark - 平衡二叉搜索树 - 子类实现(AVL➕RBT)
/** 添加节点后平衡二叉搜索树 - 子类实现 */
- (void)afterAdd:(TreeNode *)node;

/** 删除节点后平衡二叉搜索树 - 子类实现 */
- (void)afterRemove:(TreeNode *)node;

NS_ASSUME_NONNULL_END

@end


