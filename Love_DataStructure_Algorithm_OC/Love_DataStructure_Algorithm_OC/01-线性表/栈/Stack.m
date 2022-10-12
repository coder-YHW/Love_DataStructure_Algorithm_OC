//
//  Stack.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/12.
//  

#import "Stack.h"
#import "ArrayList.h"

@implementation Stack {
    ArrayList *arrayList;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        arrayList = [[ArrayList alloc] init];
    }
    return self;
}

/**元素的数量*/
- (int)size {
    return [arrayList size];
}

/** 是否为空 */
- (bool)isEmpty {
    return [arrayList isEmpty];
}

/**入栈*/
- (void)push:(id)element {
    [arrayList add:element];
}

/**出栈*/
- (id)pop {
    return [arrayList remove:arrayList.size - 1];
}

/**返回栈顶元素*/
- (id)top {
    return [arrayList get:arrayList.size - 1];
}

#pragma mark - 打印
- (NSString *)description {
    return arrayList.description;
}

@end
