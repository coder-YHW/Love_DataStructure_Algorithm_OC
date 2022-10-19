//
//  HashSet.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/7.
//

#import "HashSet.h"
#import "HashMap.h"

@interface HashSet()

/** HashMap */
@property (nonatomic,strong) HashMap *hashMap;

@end

@implementation HashSet


#pragma mark - 构造函数
- (instancetype)init{
    self = [super init];
    if (self) {
        self.hashMap = [[HashMap alloc] init];
    }
    return self;
}

#pragma mark - override
/**元素个数**/
- (int)size {
    return (int)self.hashMap.size;
}

/**是否为空**/
- (BOOL)isEmpty {
    return self.hashMap.isEmpty;
}

/**清除所有元素**/
- (void)clear {
    [self.hashMap clear];
}

/**是否包含某元素**/
- (BOOL)contains:(id)element {
    return [self.hashMap containsKey:element];
}

/**添加元素**/
- (void)add:(id)element {
    [self.hashMap put:element value:[NSNull null]]; // BShashMap会覆盖重复元素
}

/**删除元素**/
- (void)remove:(id)element {
    [self.hashMap remove:element];
}

/**遍历所有元素**/
- (void)traversalWithBlock:(MJSetTraversalBlock)block {
    [self.hashMap traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
//        NSLog(@"%@:%@", key, value);
        if (block) {
            block(key);
        }
    }];
}


@end
