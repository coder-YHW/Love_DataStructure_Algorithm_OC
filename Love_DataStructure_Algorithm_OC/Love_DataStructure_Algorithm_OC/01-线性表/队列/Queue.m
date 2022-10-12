//
//  Queue.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/13.
//  

#import "Queue.h"
#import "LinkedList.h"

@implementation Queue {
    LinkedList *linkList;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        linkList = [[LinkedList alloc] init];
    }
    return self;
}

/** 元素的数量 */
- (int)size {
    return linkList.size;
}

/** 是否为空 */
- (BOOL)isEmpty {
    return [linkList isEmpty];
}

/** 清空 */
- (void)clear {
    [linkList clear];
}

/** 入队 */
- (void)enQueue:(id)element {
    [linkList add:element];
}

/** 出队 */
- (id)deQueue {
    return [linkList remove:0];
}

/**获取队列的头元素 */
- (id)front {
    return [linkList get:0];
}

#pragma mark - 打印
- (NSString *)description {
    return linkList.description;
}

@end
