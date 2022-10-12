//
//  LinkedList.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//  

#import <Foundation/Foundation.h>
#import "LinkNode.h"
#import "AbstractList.h"

NS_ASSUME_NONNULL_BEGIN

/// 单向链表
@interface LinkedList : AbstractList

/** size*/
//@property (nonatomic,assign) int size; // 已声明
/** first代表头指针 指向第一个节点 */
@property (nonatomic,strong,nullable) LinkNode *first; 

@end

NS_ASSUME_NONNULL_END
