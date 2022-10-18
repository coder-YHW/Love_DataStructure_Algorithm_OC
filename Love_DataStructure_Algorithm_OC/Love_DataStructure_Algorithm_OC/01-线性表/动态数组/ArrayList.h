//
//  ArrayList.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/12.
//  

#import <Foundation/Foundation.h>
#import "AbstractList.h"

NS_ASSUME_NONNULL_BEGIN

/// 动态数组
@interface ArrayList : AbstractList

/** 构造函数 */
- (instancetype)initWithCapaticy:(int)capaticy;

@end

NS_ASSUME_NONNULL_END
