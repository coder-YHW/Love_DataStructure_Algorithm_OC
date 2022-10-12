//
//  Map.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// traversal - 遍历器
typedef void (^MJTraversalBlock) (id key, id value);

@interface Map : NSObject

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

/**遍历MJTraversalBlock*/
- (void)traversalWithBlock:(_Nullable MJTraversalBlock)block;

@end

NS_ASSUME_NONNULL_END
