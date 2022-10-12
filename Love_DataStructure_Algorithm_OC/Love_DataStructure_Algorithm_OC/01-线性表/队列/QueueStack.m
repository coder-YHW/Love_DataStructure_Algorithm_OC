//
//  QueueStack.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/13.
//  

#import "QueueStack.h"
#import "Stack.h"

@implementation QueueStack {
    Stack *inStack;
    Stack *outStack;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        inStack = [[Stack alloc] init];
        outStack = [[Stack alloc] init];
    }
    return self;
}

/** 元素的数量 */
- (int)size {
    return inStack.size + outStack.size;
}

/** 是否为空 */
- (BOOL)isEmpty {
    return inStack.isEmpty && outStack.isEmpty;
}

/** 清空 */
- (void)clear {
    
    while (inStack.top) {
        [inStack pop];
    }
    
    while (outStack.top) {
        [outStack pop];
    }
}

/** 入队 */
- (void)enQueue:(id)element {
    [inStack push:element];
}

/** 出队 */
- (id)deQueue {
    
    // 0、队列为空
    if([self isEmpty]) return nil;
    
    // 1、outStack不为空 从outStack出队
    if (!outStack.isEmpty) {
        return [outStack pop];
    }
    
    // 2、outStack为空 inStack不为空
    // 将inStack的元素全部压入outStack
    while (inStack.top) {  // 将inStack的元素全部压入outStack
        [outStack push:[inStack pop]];
    }
    
    // 3、再弹出outStack栈顶元素
    return [outStack pop];
}

/**获取队列的头元素 */
- (id)front {
    
    // 0、队列为空
    if([self isEmpty]) return nil;
    
    // 1、outStack不为空 获取outStack栈顶元素
    if (!outStack.isEmpty) {
        return outStack.top;
    }
    
    // 2、outStack为空 inStack不为空
    // 将inStack的元素全部压入outStack
    while (inStack.top) {  // 将inStack的元素全部压入outStack
        [outStack push:[inStack pop]];
    }
    
    // 3、再获取outStack栈顶元素
    return outStack.top;
}

#pragma mark - 打印
- (NSString *)description {
    return [NSString stringWithFormat:@"inStack:%@ - outStack:%@", inStack.description, outStack.description];
}

@end
