//
//  LinkHashMap.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/10.
//

#import "LinkHashMap.h"
#import "LinkHashNode.h"

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
    
    // 双向链表
    LinkHashNode *prev = self.last;
    if (prev == nil) { // 添加的第一个元素
        self.first = node;
        self.last = node;
    }else {
        prev.next = node;
        node.prev = prev;
        self.last = node;
    }
    
    return node;
}


#pragma mark - override
/**清除所有元素*/
- (void)clear {
    [super clear];
    
    self.first = nil;
    self.last = nil;
}


/**按照链表顺序遍历 */
// HashMap所有遍历都可以改为linkList的遍历
- (void)traversalWithBlock:(MJTraversalBlock)block {
    
    // 双向链表
    LinkHashNode *node = self.first;
    
    if (node == nil) {
        return;
    }
    
    while (node != nil) {
        
        // MJTraversalBlock
        if (block) {
            block(node.key, node.value);
        }
        
        // 下一个
        node = node.next;
    }
}

/** 删除度为2的节点 node */
- (void)fixRemoveNode1:(LinkHashNode *)node replace:(LinkHashNode *)replaceNode {
//    if (node == nil) {
//        return;
//    }
    
    // 交换node和replaceNode在链表中的位置
    
    // 1、交换prev
    LinkHashNode *tmpPrev = node.prev;
    node.prev = replaceNode.prev;
    replaceNode.prev = tmpPrev;
    
    if (node.prev == nil) {
        self.first = node;
    }else {
        node.prev.next = node;
    }
    
    if (replaceNode.prev == nil) {
        self.first = replaceNode;
    }else {
        replaceNode.prev.next = replaceNode;
    }
    
    // 2、交换next
    LinkHashNode *tmpNext = node.next;
    node.next = replaceNode.next;
    replaceNode.next = tmpNext;
    
    if (node.next == nil) {
        self.last = node;
    }else {
        node.next.prev = node;
    }
    
    if (replaceNode.next == nil) {
        self.last = replaceNode;
    }else {
        replaceNode.next.prev = replaceNode;
    }
}

/** 删除度为1或0的节点 node */
- (void)fixRemoveNode2:(LinkHashNode *)node {
//    if (node == nil) {
//        return;
//    }
    
    // 双向链表
    LinkHashNode *prev = node.prev;
    LinkHashNode *next = node.next;
    
    // 维护右向线->
    if (prev == nil) { // 删除第一个元素
        self.first = next;
    }else {
        prev.next = next;
    }
    
    // 维护左向线<-
    if (next == nil) { // 删除最后一个元素
        self.last = prev;
    }else {
        next.prev = prev;
    }
}

#pragma mark - 遍历改进
/**
 * HashMap所有遍历都可以改为linkList的遍历
 *
 *
 */

@end
