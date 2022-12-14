//
//  TreeSet.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "TreeSet.h"
#import "RBTree.h"

@interface TreeSet()

#pragma mark - 属性
/** tree */
@property (nonatomic,strong) RBTree *tree;

@end

@implementation TreeSet


#pragma mark - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        self.tree = [RBTree tree];
    }
    return self;
}


#pragma mark - override
/**元素个数**/
- (int)size {
    return (int)self.tree.size;
}

/**是否为空**/
- (BOOL)isEmpty {
    return self.tree.isEmpty;
}

/**清除所有元素**/
- (void)clear {
    [self.tree clear];
}

/**是否包含某元素**/
- (BOOL)contains:(id)element {
    return [self.tree contains:element];
}

/**添加元素**/
- (void)add:(id)element {
    [self.tree add:element]; // BSTree会覆盖重复元素
}

/**删除元素**/
- (void)remove:(id)element {
    [self.tree removeElement:element];
}

/**遍历所有元素**/
- (void)traversalWithBlock:(MJSetTraversalBlock)block {
    [self.tree levelOrderWithBlock:^(id  _Nullable element) {
        if (block) {
            block(element);
        }
    }];
}

@end
