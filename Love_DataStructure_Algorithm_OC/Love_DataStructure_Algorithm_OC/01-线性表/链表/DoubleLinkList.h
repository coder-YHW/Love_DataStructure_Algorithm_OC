//
//  DoubleLinkList.h
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import "AbstractList.h"
#import "LinkNode.h"
#import "AbstractList.h"

NS_ASSUME_NONNULL_BEGIN

/// 双向链表
@interface DoubleLinkList : AbstractList

/** size*/
//@property (nonatomic,assign) int size; // 已声明
/** first代表头指针 指向第一个节点 */
@property (nonatomic,strong,nullable) LinkNode *first;
/** last代表尾指针 指向最后一个节点 */
@property (nonatomic,strong,nullable) LinkNode *last; 

@end

NS_ASSUME_NONNULL_END
