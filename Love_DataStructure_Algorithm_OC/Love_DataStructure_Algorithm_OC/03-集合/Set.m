//
//  Set.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "Set.h"

@implementation Set

/**元素个数**/
- (int)size {
    return 0;
}

/**是否为空**/
- (BOOL)isEmpty {
    return YES;
}

/**清除所有元素**/
- (void)clear {}

/**是否包含某元素**/
- (BOOL)contains:(id)element {
    return NO;
}

/**添加元素**/
- (void)add:(id)element {}

/**删除元素**/
- (void)remove:(id)element {}

/**遍历所有元素**/
- (void)traversalWithBlock:(MJSetTraversalBlock)block {}

/// 所有元素
- (NSMutableArray *)allElement {
    
    NSMutableArray *elements = [NSMutableArray array];
    
    [self traversalWithBlock:^(id  _Nonnull element) {
        [elements addObject:element];
    }];
    
    return elements;
}

@end
