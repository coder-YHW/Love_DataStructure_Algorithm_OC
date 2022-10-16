//
//  Sort.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sort : NSObject

#pragma mark - 属性
/// 存储数组
@property (nonatomic,strong)  NSMutableArray *dataArray;

#pragma mark - 方法
- (NSMutableArray *)sortedWithArray:(NSMutableArray *)array;

#pragma mark - 子类实现
- (void)sortAction;

#pragma mark - 辅助方法
/*
 * 根据索引比较
 * 返回值等于0，代表 array[i1] == array[i2]
 * 返回值小于0，代表 array[i1] < array[i2]
 * 返回值大于0，代表 array[i1] > array[i2]
 */
- (int)cmpIndex1:(int)index1 index2:(int)index2;

/// 直接比较值
- (int)cmpElement1:(id)element1 element2:(id)element2;

/// 交换值
- (void)swapIndex1:(int)index1 index2:(int)index2;

@end

NS_ASSUME_NONNULL_END
