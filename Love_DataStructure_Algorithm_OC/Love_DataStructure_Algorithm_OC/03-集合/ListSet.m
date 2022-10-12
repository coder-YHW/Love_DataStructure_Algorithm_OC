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
@property(nonatomic,strong)LinkedList *list;

@end

@implementation ListSet

- (instancetype)init {
    self = [super init];
    if (self) {
        self.list = [[LinkedList alloc] init];
    }
    return self;
}

#pragma mark - override
/**元素个数**/
- (int)size {
    return (int)self.list.size;
}

/**是否为空**/
- (BOOL)isEmpty {
    return self.list.isEmpty;
}

/**清除所有元素**/
- (void)clear {
    [self.list clear];
}

/**是否包含某元素**/
- (BOOL)contains:(id)element {
    return [self.list contains:element];
}

/**添加元素**/
- (void)add:(id)element {
    
    NSUInteger index = [self.list indexOfElement:element];
    
    if (index == NSNotFound) {  // 不存在就添加
        [self.list add:element];
    } else {
        [self.list set:index element:element];
    }
}

/**删除元素**/
- (void)remove:(id)element {
    
    NSInteger index = [self.list indexOfElement:element];
    
    if (index != NSNotFound) {  // 存在
        [self.list remove:index];
    }
}

/**遍历所有元素**/
- (void)traversal {
    for (int i = 0; i < self.list.size; i++) {
        NSLog(@"%@",[self.list get:i]);
    }
}

@end
