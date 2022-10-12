//
//  DoubleCircleLinkedList.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/8.
//  

#import <Foundation/Foundation.h>
#import "LinkNode.h"
#import "AbstractList.h"

NS_ASSUME_NONNULL_BEGIN

/// 双向循环链表
@interface DoubleCircleLinkedList : AbstractList

/** size*/
//@property (nonatomic,assign) int size; // 已声明
/** first代表头指针 指向第一个节点 */
@property (nonatomic,strong,nullable) LinkNode *first;
/** last代表尾指针 指向最后一个节点 */
@property (nonatomic,strong,nullable) LinkNode *last; 


#pragma mark - 循环链表属性增强
/** curren代表指针现在的指针 指向当前所在的节点*/
@property (nonatomic,strong,nullable) LinkNode *current; 

#pragma mark - 循环链表方法增强
/// reset
- (void)reset;

/// 下一个
- (id)next;

/// remove
- (id)remove;

@end

NS_ASSUME_NONNULL_END
