//
//  LinkNode.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//  

#import "LinkNode.h"

@implementation LinkNode

#pragma mark - 构造函数
/**单向节点-构造函数**/
- (instancetype)initWithElement:(id)element next:(nullable LinkNode *)next {
    self = [super init];
    if (self) {
        self.element = element;
        self.next = next;
    }
    return self;
}

/**双向节点-构造函数**/
- (instancetype)initWithPrev:(nullable LinkNode *)prev element:(id)element next:(nullable LinkNode *)next {
    self = [super init];
    if (self) {
        self.element = element;
        self.next = next;
        self.prev = prev;
    }
    return self;
}

@end
