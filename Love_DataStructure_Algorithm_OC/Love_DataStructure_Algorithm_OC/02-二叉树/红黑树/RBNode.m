//
//  RBNode.m
//  OC
//
//  Created by 余衡武 on 2022/10/5.
//

#import "RBNode.h"

@implementation RBNode

#pragma mark - 重写 - 初始化方法
/** 重写 - 初始化方法 */
- (instancetype)initWithElement:(id)element parent:(nullable TreeNode *)parent {
    self = [super init];
    if (self) {
        self.element = element;
        self.parent = parent;
        self.color = RBTreeNodeTypeRed; // 新添加的节点默认为红色节点，这样能让红黑树性质尽快满足
    }
    return self;
}


@end
