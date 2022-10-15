//
//  ListSet.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "ListSet.h"
#import "LinkedList.h"

@interface ListSet()

/** list*/
@property(nonatomic,strong)LinkedList *linkList;

@end

@implementation ListSet

- (instancetype)init {
    self = [super init];
    if (self) {
        self.linkList = [[LinkedList alloc] init];
    }
    return self;
}

#pragma mark - override
/**元素个数**/
- (int)size {
    return (int)self.linkList.size;
}

/**是否为空**/
- (BOOL)isEmpty {
    return self.linkList.isEmpty;
}

/**清除所有元素**/
- (void)clear {
    [self.linkList clear];
}

/**是否包含某元素**/
- (BOOL)contains:(id)element {
    return [self.linkList contains:element];
}

/**添加元素**/
- (void)add:(id)element {
    
    int index = [self.linkList indexOfElement:element];
    
    if (index == Default_NotFound) {  // 不存在才添加
        [self.linkList add:element];
    }
}

/**删除元素**/
- (void)remove:(id)element {
    
    int index = [self.linkList indexOfElement:element];
    
    if (index != Default_NotFound) {  // 存在才删除
        [self.linkList remove:index];
    }
}

/**遍历所有元素**/
- (void)traversalWithBlock:(MJSetTraversalBlock)block {
    
    for (int i = 0; i < self.linkList.size; i++) {
    
        id obj = [self.linkList get:i];
        if (block) {
            block(obj);
        }
        NSLog(@"%@",obj);
    }
}

@end
