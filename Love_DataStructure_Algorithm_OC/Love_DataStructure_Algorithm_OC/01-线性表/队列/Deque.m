//
//  Deque.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/14.
//  

#import "Deque.h"
#import "LinkedList.h"

@implementation Deque {
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
    return linkList.isEmpty;
}

/** 清空 */
- (void)clear {
    [linkList clear];
}

/** 从前面入队 */
- (void)enQueueFront:(id)element {
    [linkList add:0 element:element];
}

/** 从后面入队 */
- (void)enQueueRear:(id)element {
    [linkList add:element];
}

/** 从前面出队 */
- (id)deQueueFront {
    return [linkList remove:0];
}

/** 从后面出队 */
- (id)deQueueRear {
    return [linkList remove:linkList.size - 1];
}

/**获取队列的头元素 */
- (id)front {
    return [linkList get:0];
}

/** 获取队列的尾元素 */
- (id)rear {
    return [linkList get:linkList.size - 1];
}


#pragma mark - 打印
- (NSString *)description {
    return linkList.description;
}

@end
