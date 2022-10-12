//
//  RBTree.h
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "BBSTree.h"

NS_ASSUME_NONNULL_BEGIN

/// 红黑树 - 4阶B树 - （2-3-4树）
@interface RBTree : BBSTree

/**
 * 红黑树必须满足以下5个性质
 * 1、所有节点不是Red，就是Black
 * 2、根节点是Black
 * 3、叶子结点（外部节点、空节点）都是Black
 * 4、Red节点的子节点都是Black，Red节点的父节点都是Black
 *   也就是说从根节点到叶子结点的所有路径上不能有2个连续的Red节点
 * 5、从任一节点到叶子结点的所有路径都包含相同数目的Black节点
 */


/**
 * 红黑树既是一种自平衡的二叉搜索树，又等价于4阶B树 （2-3-4树）
 * 1、B树中，新元素必定是添加到叶子结点中
 * 2、4阶B树所有节点的元素个数x都符合 (1<= x <=3)
 * 3、建议新添加的节点默认为红色节点，这样能让红黑树性质尽快满足
 *  （红黑树性质1、2、3、5都满足，性质4不一定满足）
 */


@end

NS_ASSUME_NONNULL_END
