//
//  PriorityQueue.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "PriorityQueue.h"
#import "BinaryHeap.h"

@implementation PriorityQueue {
    BinaryHeap *_heap;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _heap = [BinaryHeap heapWithComparatorBlock:^int(id  _Nonnull e1, id  _Nonnull e2) {
            return (int)[e1 compare:e2]; // 比较优先级
        }];
    }
    return self;
}

- (int)size {
    return _heap.size;
}

- (BOOL)isEmpty {
    return _heap.isEmpty;
}

- (void)clear {
    [_heap clear];
}

- (void)enQueue:(id)element {
    [_heap add:element];
}

- (id)deQueue {
    return [_heap remove];
}

- (id)front {
    return _heap.get;
}

@end
