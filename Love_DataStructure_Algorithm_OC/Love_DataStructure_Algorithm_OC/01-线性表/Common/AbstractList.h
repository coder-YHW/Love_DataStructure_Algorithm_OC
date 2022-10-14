//
//  AbstractList.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//  

#import <Foundation/Foundation.h>
#import "List.h"

NS_ASSUME_NONNULL_BEGIN

/// 线性表-抽象基类 （实现部分通用接口 其他由子类实现）
@interface AbstractList : List

#pragma mark - 属性
/** size*/
@property (nonatomic,assign) int size;


#pragma mark - 方法
/**越界查询 - index < 0 || index >= _size */
- (bool)rangeCheck:(int)index;

/**add越界查询 - index < 0 || index > _size */
- (bool)rangeCheckForAdd:(int)index;

@end

NS_ASSUME_NONNULL_END
