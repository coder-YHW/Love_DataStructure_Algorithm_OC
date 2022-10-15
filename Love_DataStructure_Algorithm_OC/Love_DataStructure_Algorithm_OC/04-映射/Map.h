//
//  Map.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// traversal - 遍历器
typedef void (^MJMapTraversalBlock) (id key, id value);

@interface Map : NSObject

#pragma mark - 接口方法
/**元素个数*/
- (int)size;

/**是否为空*/
- (BOOL)isEmpty;

/**清除所有元素*/
- (void)clear;

/**添加元素*/
- (void)put:(id)key value:(id)value;

/**根据元素查询value*/
- (id)get:(id)key;

/**删除元素*/
- (void)remove:(id)key;

/**是否包含Key*/
- (BOOL)containsKey:(id)key;

/**是否包含Value*/
- (BOOL)containsValue:(id)value;

/**遍历MJMapTraversalBlock*/
- (void)traversalWithBlock:(_Nullable MJMapTraversalBlock)block;

/// 所有key
- (NSArray *)allkeys;

///  所有values
- (NSArray *)allValues;

@end

NS_ASSUME_NONNULL_END
