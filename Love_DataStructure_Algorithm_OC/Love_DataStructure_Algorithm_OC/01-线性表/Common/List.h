//
//  List.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//  

#import <Foundation/Foundation.h>

static int Default_NotFound = -1;

NS_ASSUME_NONNULL_BEGIN

/// 线性表-通用接口设计
@interface List : NSObject


#pragma mark - 接口方法
/**
 * 元素的数量
 */
- (int)size;

/**
 * 是否为空
 */
- (bool)isEmpty;

/**
 * 清除所有元素
 */
- (void)clear;

/**
 * 添加元素到尾部
 */
- (void)add:(id)element;

/**
 * 在index位置插入一个元素
 */
- (void)add:(int)index element:(id)element;

/**
 * 删除index位置的元素
 */
- (id)remove:(int)index;

/**
 * 设置index位置的元素
 */
- (id)set:(int)index element:(id)element;

/**
 * 获取index位置的元素
 */
- (id)get:(int)index;

/**
 * 查看元素的索引
 */
- (int)indexOfElement:(id)element;

/**
 * 是否包含某个元素
 */
- (bool)contains:(id)element;

@end

NS_ASSUME_NONNULL_END
