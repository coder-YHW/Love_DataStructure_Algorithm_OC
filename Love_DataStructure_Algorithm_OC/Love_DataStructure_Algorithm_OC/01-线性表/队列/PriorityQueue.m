//
//  PriorityQueue.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "PriorityQueue.h"
#import "BinaryHeap.h"

#pragma mark - 属性
@implementation PriorityQueue {
    BinaryHeap *heap;
}


#pragma mark - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        heap = [BinaryHeap heapWithComparatorBlock:^int(id  _Nonnull e1, id  _Nonnull e2) {
            return (int)[e1 compare:e2]; // 比较优先级
        }];
    }
    return self;
}


#pragma mark - 方法
- (int)size {
    return heap.size;
}

- (BOOL)isEmpty {
    return heap.isEmpty;
}

- (void)clear {
    [heap clear];
}

- (void)enQueue:(id)element {
    [heap add:element];
}

- (id)deQueue {
    return [heap remove];
}

- (id)front {
    return heap.get;
}

#pragma mark - 打印
- (NSString *)description {
    return heap.description;
}

@end
