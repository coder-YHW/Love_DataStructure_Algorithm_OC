//
//  TreeNode.h
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 二叉树节点
@interface TreeNode : NSObject

#pragma mark - 属性
/** id*/
@property (nonatomic,strong) id element;
/** left*/
@property (nonatomic,strong,nullable) TreeNode *left;
/** right*/
@property (nonatomic,strong,nullable) TreeNode *right;
/** parent*/
@property (nonatomic,strong,nullable) TreeNode *parent;


#pragma mark - 构造函数
/** 初始化 - 根结点parent为nil   */
- (instancetype)initWithElement:(id)element parent:(nullable TreeNode *)parent;


#pragma mark - 方法
/** 是否是叶子节点 */
- (BOOL)isLeaf;

/** 是否有两个子树 */
- (BOOL)hasTwoChildren;

/** 是否有左个子树 */
- (BOOL)hasLeftChild;

/** 是否有右子树 */
- (BOOL)hasRightChild;

/** 是否是parent的左子树 */
- (BOOL)isLeftChild;

/** 是否是parent的右子树 */
- (BOOL)isRightChild;

/** 返回兄弟节点 */
- (TreeNode *)sibling;

@end

NS_ASSUME_NONNULL_END
