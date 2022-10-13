//
//  Stack.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/12.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 栈
@interface Stack : NSObject

/**元素的数量*/
- (int)size;

/** 是否为空 */
- (bool)isEmpty;

/**清空*/
- (void)clear;

/**入栈*/
- (void)push:(id)element;

/**出栈*/
- (id)pop;

/**返回栈顶元素*/
- (id)top;

@end

NS_ASSUME_NONNULL_END
