//
//  QueueStack.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/13.
//

#import "QueueStack.h"
#import "Queue.h"

@implementation QueueStack{
    Queue *dataQueue;
    Queue *tempQueue;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        dataQueue = [[Queue alloc] init];
        tempQueue = [[Queue alloc] init];
    }
    return self;
}

/**元素的数量*/
- (int)size {
    return dataQueue.size;
}

/** 是否为空 */
- (bool)isEmpty {
    return dataQueue.isEmpty;
}

/**清空*/
- (void)clear {
    [dataQueue clear];
}

/**入栈*/
- (void)push:(id)element {
    [dataQueue enQueue:element];
}

/**出栈*/
- (id)pop {
    
    // 0、栈为空
    if (dataQueue.isEmpty) {
        return nil;
    }
    
    // 1、将dataQueue元素留最后一个 其他都出队到tempQueue
    for (int i = 0 ; i < dataQueue.size - 1 ; i++) {
        [tempQueue enQueue:[dataQueue deQueue]];
    }
    
    // 2、将tempQueue元素都出队到dataQueue
    for (int i = 0 ; i < tempQueue.size ; i++) {
        [dataQueue enQueue:[tempQueue deQueue]];
    }
    
    // 3、将dataQueue队头元素都出队
    return [dataQueue deQueue];
}

/**返回栈顶元素*/
- (id)top {
    
    // 0、栈为空
    if (dataQueue.isEmpty) {
        return nil;
    }
    
    // 1、将dataQueue元素留最后一个 其他都出队到tempQueue
    for (int i = 0 ; i < dataQueue.size - 1 ; i++) {
        [tempQueue enQueue:[dataQueue deQueue]];
    }
    
    // 2、将dataQueue最后一个元素element出队 零时保存
    id element = [dataQueue deQueue];
    
    // 3、将tempQueue元素都出队到dataQueue
    for (int i = 0 ; i < tempQueue.size ; i++) {
        [dataQueue enQueue:[tempQueue deQueue]];
    }
    
    // 4、将tdataQueue最后一个元素element入队到dataQueue
    [dataQueue enQueue:element];
    
    // 5、将dataQueue最后一个元素element返回
    return element;
}

@end
