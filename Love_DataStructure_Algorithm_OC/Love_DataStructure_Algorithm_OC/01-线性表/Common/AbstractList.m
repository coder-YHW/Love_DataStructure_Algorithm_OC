//
//  AbstractList.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//  

#import "AbstractList.h"

@implementation AbstractList

#pragma mark - 实现部分接口 其他由子类实现
/// 数量
- (int)size {
    return _size; // 这里的_不能省略（- (int)size 方法没实现 点语法无法访问）
}

/** 是否为空 */
- (bool)isEmpty {
    return _size == 0;
}

/** 是否包含某个元素 */
- (bool)contains:(id)element {
    return [self indexOfElement:element] != Default_NotFound;
}

/**  添加元素到尾部 */
- (void)add:(id)element {
    [self add:_size element:element];
}

#pragma mark - 越界查询
- (void)outOfBounds:(int)index {
    NSLog(@"索引越界：index:%lu, size:%lu",(unsigned long)index,(unsigned long)_size);
}

/**越界查询 - iindex < 0 || index >= _size */
- (bool)rangeCheck:(int)index {
    if (index < 0 || index >= _size) {
        [self outOfBounds:index];
        return YES;
    }
    return NO;
}

/**add越界查询 - index < 0 || index > _size */
- (bool)rangeCheckForAdd:(int)index {
    if (index < 0  || index > _size) {
        [self outOfBounds:index];
        return YES;
    }
    return NO;
}

@end
