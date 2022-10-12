//
//  RBNode.h
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "TreeNode.h"

//typedef enum : NSUInteger {
//    Red = 0,
//    Black = 1,
//}RBTreeNodeType;

/**红黑树节点颜色*/
typedef NS_ENUM(NSInteger, RBTreeNodeType) {
    RBTreeNodeTypeRed       = 0,  // 0：红色 - 默认
    RBTreeNodeTypeBlack     = 1,  // 1：黑色
};


NS_ASSUME_NONNULL_BEGIN

/// 红黑树节点
@interface RBNode : TreeNode

#pragma mark - 接口属性
/** color type */
@property (nonatomic,assign) RBTreeNodeType color;



@end

NS_ASSUME_NONNULL_END
