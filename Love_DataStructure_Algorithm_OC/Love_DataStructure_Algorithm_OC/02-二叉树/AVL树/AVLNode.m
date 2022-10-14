//
//  AVLNode.m
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "AVLNode.h"

@implementation AVLNode

#pragma mark - 接口方法
/** 重写 - 初始化方法 */
- (instancetype)initWithElement:(id)element parent:(nullable TreeNode *)parent {
    self = [super init];
    if (self) {
        self.element = element;
        self.parent = parent;
        self.height = 1; // 1、结点高度：1 + MAX(leftHeight, rightHeight); 2、叶子结点的高度为1
    }
    return self;
}

#pragma mark - 接口方法
/** AVL树 - 平衡因子 */
- (int)balanceFactor {
    
    // 左子树高度
    int leftHeight = self.left == nil ? 0 : ((AVLNode *)(self.left)).height;
    // 右子树高度
    int rightHeight = self.right == nil ? 0 : ((AVLNode *)(self.right)).height;
    
    return leftHeight - rightHeight;
}

/** AVL树 - 更新高度 */
- (void)updateHeight {
    
    // 左子树高度
    int leftHeight = self.left == nil ? 0 : ((AVLNode *)(self.left)).height;
    // 右子树高度
    int rightHeight = self.right == nil ? 0 : ((AVLNode *)(self.right)).height;
    
    // 由下往上更新父节点高度 - 巧妙
    self.height = 1 + MAX(leftHeight, rightHeight);
}

/** 返回节点数较多的节点 */
- (TreeNode *)tallerChild {
    
    // 左子树高度
    int leftHeight = self.left == nil ? 0 : ((AVLNode *)(self.left)).height;
    // 右子树高度
    int rightHeight = self.right == nil ? 0 : ((AVLNode *)(self.right)).height;
    
    if (leftHeight > rightHeight) { // 1、左子树高
        return self.left;
    } else if (leftHeight < rightHeight) { // 2、右子树高
        return self.right;
    }
    
    return [self isLeftChild] ? self.left : self.right; // 3、左子树 == 右子树
}


@end
