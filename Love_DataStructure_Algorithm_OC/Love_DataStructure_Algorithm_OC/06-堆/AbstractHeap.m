//
//  AbstractHeap.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "AbstractHeap.h"

@implementation AbstractHeap

- (int)size {
    return _size;
}

- (bool)isEmpty {
    return _size == 0;
}


#pragma mark - 实现MJBinaryTreeInfo协议方法-打印TreeMap
- (id)root {
    return @0;
}

- (id)left:(id)node {
    int index =  [node intValue];
    index = (index << 1) + 1;
    
    if(index >= self.size) { // 数组越界
        return nil;
    }else {
        return @(index);
    }
}

- (id)right:(id)node {
    int index =  [node intValue];
    index = (index << 1) + 2;
    
    if(index >= self.size) { // 数组越界
        return nil;
    }else {
        return @(index);
    }
}

- (id)string:(id)node {
    NSLog(@"需要子类去重写");
    return node;
}

@end
