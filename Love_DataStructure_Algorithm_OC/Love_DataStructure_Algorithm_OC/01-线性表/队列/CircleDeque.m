//
//  CircleDeque.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/14.
//  

#import "CircleDeque.h"
#import "ArrayListUpgrade.h"

static int kDefaultCapacity = 10;   // 默认元素个数

@implementation CircleDeque {
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

/// 从头部入队
- (void)enQueueFront:(id)element {
    [arrayList add:0 element:element];
}

/** 从后面入队 */
- (void)enQueueRear:(id)element {
    [arrayList add:element];
}

 /** 从前面出队 */
- (id)deQueueFront {
    return [arrayList remove:0];
}

/** 从后面出队 */
- (id)deQueueRear {
    return [arrayList remove:(arrayList.size - 1)];
}

/**获取队列的头元素 */
- (id)front {
    return [arrayList get:0];
}

/** 获取队列的尾元素 */
- (id)rear {
    return  [arrayList get:(arrayList.size - 1)];
}


#pragma mark - 打印
- (NSString *)description {
    return arrayList.description;
}


@end
