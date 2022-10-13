//
//  Queue.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/13.
//  

#import "Queue.h"
#import "ArrayList.h"

#pragma mark - 属性
@implementation Queue {
    ArrayList *arrayList;
}


#pragma mark - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        arrayList = [[ArrayList alloc] init];
    }
    return self;
}


#pragma mark - 方法
/** 元素的数量 */
- (int)size {
    return arrayList.size;
}

/** 是否为空 */
- (BOOL)isEmpty {
    return [arrayList isEmpty];
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
    return [arrayList remove:0];
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
