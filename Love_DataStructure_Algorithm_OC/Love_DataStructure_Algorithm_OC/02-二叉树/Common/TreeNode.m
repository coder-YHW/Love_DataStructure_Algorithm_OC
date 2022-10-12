//
//  TreeNode.m
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import "TreeNode.h"

@implementation TreeNode

/** 初始化 */
- (instancetype)initWithElement:(id)element parent:(nullable TreeNode *)parent {
    self = [super init];
    if (self) {
        self.element = element;
        self.parent = parent;
    }
    return self;
}

/** 是否是叶子节点 */
- (BOOL)isLeaf {
    return self.left == nil && self.right == nil;
}

/** 是否有两个子树 */
- (BOOL)hasTwoChildren {
    return self.left != nil && self.right != nil;
}

/** 是否有左个子树 */
- (BOOL)hasLeftChild {
    return self.left != nil;
}

/** 是否有右子树 */
- (BOOL)hasRightChild {
    return self.right != nil;
}

/** 是否是parent的左子树 */
- (BOOL)isLeftChild {
    return self.parent != nil && self == self.parent.left;
}

/** 是否是parent的右子树 */
- (BOOL)isRightChild {
    return self.parent != nil && self == self.parent.right;
}

/// 返回兄弟节点
- (TreeNode *)sibling {
    
    if ([self isLeftChild]) {
        return self.parent.right;
    }
    
    if ([self isRightChild]) {
        return self.parent.left;
    }
    
    return nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.element];
}

@end
