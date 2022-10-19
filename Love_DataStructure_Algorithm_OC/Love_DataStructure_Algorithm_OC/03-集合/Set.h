//
//  Set.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// traversal - 遍历器
typedef void (^MJSetTraversalBlock) (id element);

/// 集合特性 - 去除重复元素
/// 集合 - 接口设计
@interface Set : NSObject

#pragma mark - 接口设计
/**元素个数**/
- (int)size;

/**是否为空**/
- (BOOL)isEmpty;

/**清除所有元素**/
- (void)clear;

/**是否包含某元素**/
- (BOOL)contains:(id)element;

/**添加元素**/
- (void)add:(id)element;

/**删除元素**/
- (void)remove:(id)element;

/**遍历所有元素**/
- (void)traversalWithBlock:(_Nullable MJSetTraversalBlock)block;

/// 所有元素
- (NSMutableArray *)allElement;


@end

NS_ASSUME_NONNULL_END
