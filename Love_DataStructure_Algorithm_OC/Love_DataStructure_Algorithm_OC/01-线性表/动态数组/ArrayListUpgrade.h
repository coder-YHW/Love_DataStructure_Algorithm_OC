//
//  ArrayListUpgrade.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/8.
//

#import "AbstractList.h"

NS_ASSUME_NONNULL_BEGIN

/// 动态数组加强版 - 优化环形内存
@interface ArrayListUpgrade : AbstractList

/** 初始化 */
- (instancetype)initWithCapaticy:(int)capaticy;

@end

NS_ASSUME_NONNULL_END
