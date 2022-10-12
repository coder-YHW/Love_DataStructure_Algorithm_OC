//
//  MapNode.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//


#import "MapNode.h"

@implementation MapNode

#pragma mark - 构造方法
- (instancetype)initWithKey:(id)key value:(id)value parent:(nullable MapNode *)parent {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
        self.parent = parent;
        self.color = MapNodeTypeRed;
    }
    return self;
}


#pragma mark - 通用接口
/** 是否是叶子节点 */
- (BOOL)isLeaf {
    return self.left == nil && self.right == nil;
}

/** 是否有两个子树 */
- (BOOL)hasTwoChildren {
    return self.left != nil && self.right != nil;
}

/** 是否是parent的左子树 */
- (BOOL)isLeftChild {
    return self.parent != nil && self == self.parent.left;
}

/** 是否是parent的右子树 */
- (BOOL)isRightChild {
    return self.parent != nil && self == self.parent.right;
}

/** 返回兄弟节点 */
- (MapNode *)sibling {
    if ([self isLeftChild]) {
        return self.parent.right;
    }
    
    if ([self isRightChild]) {
        return self.parent.left;
    }
    
    return nil;
}

@end
