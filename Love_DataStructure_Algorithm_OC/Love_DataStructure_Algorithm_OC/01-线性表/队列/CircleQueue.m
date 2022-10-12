//
//  CircleQueue.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/14.
//  

#import "CircleQueue.h"
#import "ArrayListUpgrade.h"

static int kDefaultCapacity = 10;   // 默认元素个数

@implementation CircleQueue {
    ArrayListUpgrade *arrayList;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        arrayList = [[ArrayListUpgrade alloc] initWithCapaticy:kDefaultCapacity];
    }
    return self;
}

/** 元素的数量 */
- (int)size {
    return arrayList.size;
}

/** 是否为空 */
- (BOOL)isEmpty {
    return arrayList.size == 0;
}

/** 清空 */
- (void)clear {
    [arrayList clear];
}

/** 入队 */
- (void)enQueue:(id)element {
    [arrayList add:element];
}

/** 出队 */
- (id)deQueue {
    id frontElement = [arrayList remove:0];
    return frontElement;
}

/**获取队列的头元素 */
- (id)front {
    return [arrayList get:0];
}


#pragma mark - 打印
- (NSString *)description {
    return arrayList.description;
}

@end
