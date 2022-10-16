//
//  LinkHashMap.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/10.
//

#import "LinkHashMap.h"
#import "LinkHashNode.h"

/// 1、添加修复LinkHashMap性质 - 重写createNode构造函数
/// 2、删除修复LinkHashMap性质 - 重写fixLinkHashMapAfterRemove1和fixLinkHashMapAfterRemove2
/// 3、clear时 记得清空first和last指针
@interface LinkHashMap ()

/** first*/
@property (nonatomic,strong,nullable) LinkHashNode *first; // first代表指针
/** last*/
@property (nonatomic,strong,nullable) LinkHashNode *last;  // last代表指针

@end

@implementation LinkHashMap


#pragma mark - 初始化 - LinkHashNode  - 子类重写
/** 初始化 - LinkHashNode  - 子类重写*/
- (LinkHashNode *)createNodeWithKey:(id)key value:(id)value parent:(nullable LinkHashNode *)parent {
    
    LinkHashNode *node = [[LinkHashNode alloc] initWithKey:key value:value parent:parent];
    
    // 1、修复LinkHashMap性质:(双向链表 - 往链表最后面添加元素)
    LinkHashNode *prev = self.last;
    if (prev == nil) { // 添加的第一个元素
        self.first = node;
        self.last = node;
    }else { // 添加的其他元素
        prev.next = node;
        node.prev = prev;
        self.last = node;
    }
    
    return node;
}


#pragma mark - override
/** 2、修复LinkHashMap性质 - 删除度为2的节点 node */
- (void)fixLinkHashMapAfterRemove2:(LinkHashNode *)node replace:(LinkHashNode *)replaceNode {
//    if (node == nil) {
//        return;
//    }
    
    // 交换node和replaceNode在双向链表中的位置
    
    // 1.1、交换prev
    LinkHashNode *tmpPrev = node.prev;
    node.prev = replaceNode.prev;
    replaceNode.prev = tmpPrev;
    // 1.2、交换next
    LinkHashNode *tmpNext = node.next;
    node.next = replaceNode.next;
    replaceNode.next = tmpNext;
    
    
    // 2、维护node的2根线
    LinkHashNode *prev1 = node.prev;
    LinkHashNode *next1 = node.next;
    
    // 2.1、维护右向线-> prev.next
    if (prev1 == nil) { // 删除第一个元素
        self.first = node;
    }else {
        prev1.next = node;
    }
    
    // 2.2、维护左向线<- next.prev
    if (next1 == nil) { // 删除最后一个元素
        self.last = node;
    }else {
        next1.prev = node;
    }
    
    // 3、维护replaceNode的2根线
    LinkHashNode *prev2 = replaceNode.prev;
    LinkHashNode *next2 = replaceNode.next;
    
    // 3.1、维护右向线-> prev.next
    if (prev2 == nil) { // 删除第一个元素
        self.first = replaceNode;
    }else {
        prev2.next = replaceNode;
    }
    
    // 3.2、维护左向线<- next.prev
    if (next2 == nil) { // 删除最后一个元素
        self.last = replaceNode;
    }else {
        next2.prev = replaceNode;
    }
}

/** 3、修复LinkHashMap性质 - 删除度为1或0的节点 node */
- (void)fixLinkHashMapAfterRemove1:(LinkHashNode *)node {
//    if (node == nil) {
//        return;
//    }
    
    // 双向链表
    LinkHashNode *prev = node.prev;
    LinkHashNode *next = node.next;
    
    // 维护右向线-> prev.next
    if (prev == nil) { // 删除第一个元素
        self.first = next;
    }else {
        prev.next = next;
    }
    
    // 维护左向线<- next.prev
    if (next == nil) { // 删除最后一个元素
        self.last = prev;
    }else {
        next.prev = prev;
    }
}

/**清除所有元素*/
- (void)clear {
    [super clear];
    
    self.first = nil;
    self.last = nil;
}


/**按照链表顺序遍历 */
// HashMap所有遍历都可以改为linkList的遍历
- (void)traversalWithBlock:(MJMapTraversalBlock)block {
    
    // 双向链表
    LinkHashNode *node = self.first;
    
    if (node == nil) {
        return;
    }
    
    while (node != nil) {
        
        // MJMapTraversalBlock
        if (block) {
            block(node.key, node.value);
        }
        
        // 下一个
        node = node.next;
    }
}

#pragma mark - 遍历改进
/**
 * HashMap所有遍历都可以改为linkList的遍历
 *
 *
 */

@end
