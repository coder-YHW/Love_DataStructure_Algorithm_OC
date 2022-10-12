//
//  AVLNode.h
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "TreeNode.h"

NS_ASSUME_NONNULL_BEGIN

/// AVL树节点
@interface AVLNode : TreeNode

#pragma mark - 接口属性
/** int - 高度*/
@property(nonatomic,assign)int height;

#pragma mark - 接口方法
/** AVL树 - 平衡因子 */
- (int)balanceFactor;

/** AVL树 - 更新高度 */
- (void)updateHeight;

/** 返回节点数较多的节点 */
- (TreeNode *)tallerChild;

@end

NS_ASSUME_NONNULL_END
