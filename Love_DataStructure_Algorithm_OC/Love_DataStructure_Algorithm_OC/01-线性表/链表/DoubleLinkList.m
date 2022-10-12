//
//  DoubleLinkList.m
//  OC
//
//  Created by 余衡武 on 2022/10/4.
//

#import "DoubleLinkList.h"

@implementation DoubleLinkList

#pragma mark - override
- (void)clear {
    self.size = 0;
    self.first = nil;
    self.last = nil;
}

- (int)indexOfElement:(id)element {
    
    if (element == nil) {   // 返回节点中第一个出现元素为空的节点
        LinkNode *node = self.first;
        for (int i = 0; i < self.size; i++) {
            if (node.element == nil) {
                return i;
            }
            node = node.next;
        }
    } else {
        LinkNode *node = self.first;
        for (int i = 0; i < self.size; i++) {
            if (node.element == element) {
                return i;
            }
            node = node.next;
        }
    }
    
    return Default_NotFound;
}

/**  获取index位置对应的节点对象  - 双向遍历*/
- (LinkNode *)nodeOfIndex:(int)index {
    if ([self rangeCheck:index]) {
        return nil;
    }
    
    // 前半部分 ➕ 后半部分
    if (index < self.size * 0.5) { // 前半部分 - 顺序遍历 0 <= i < index
        
        LinkNode *node = self.first;
        for (int i = 0; i < index; i++) {
            node = node.next;
        }
        return node;
        
    } else { // 后半部分 - 逆序遍历  (index + 1) <= i < count
        
        LinkNode *node = self.last;
        for (int i = self.size - 1; i >= (index + 1); i--) {
            node = node.prev;
        }
         
        return node;
    }
}

- (id)get:(int)index {
    return [self nodeOfIndex:index].element;
}

- (id)set:(int)index element:(id)element {
    if ([self rangeCheck:index]) {
        return nil;
    }
    
    LinkNode *node = [self nodeOfIndex:index];
    id oldElement  = node.element;
    node.element = element;
    return oldElement;
}


#pragma mark - 添加删除
/** 在索引为index处插入元素值为element的节点 */
- (void)add:(int)index element:(id)element {
    if ([self rangeCheckForAdd:index]) {
        return;
    }
    
    if (index == 0) { // 1、往表头添加一个节点
        
        LinkNode *oldFirst = self.first;
        self.first = [[LinkNode alloc] initWithPrev:nil element:element next:oldFirst];
        
        if (oldFirst == nil) { // 1.1、添加第一个节点
            self.last = self.first;
        }else { // 1.2、往表头添加一个节点
            oldFirst.prev = self.first;
        }
        
    }else if (index == self.size) { // 2、往表尾添加一个节点
        
        LinkNode *oldLast = self.last; // 前驱节点
        self.last = [[LinkNode alloc] initWithPrev:oldLast element:element next:nil];
        
        if (oldLast == nil) {   // 2.1、添加第一个节点（重复判断 - 可以省略）
            self.first = self.last;
        } else {  // 2.2、往表尾添加一个节点
            oldLast.next = self.last;
        }
        
    } else {   // 3、在中间插入节点 - 前后都有节点
        
        LinkNode *next = [self nodeOfIndex:index]; // 获取后继节点 - 肯定存在
        LinkNode *prev = next.prev; // // 获取前驱节点 - 肯定存在
        LinkNode *node = [[LinkNode alloc] initWithPrev:prev element:element next:next];
        prev.next  = node;
        next.prev = node;
    }
    
    self.size++;
}

/** 删除索引为index的节点 */
- (id)remove:(int)index {
    if ([self rangeCheck:index]) {
        return nil;
    }
    return [self removeLinkNode:[self nodeOfIndex:index]];
}

/** 删除node节点 */
- (id)removeLinkNode:(LinkNode *)node {
     
    LinkNode *prev = node.prev;
    LinkNode *next = node.next;
    
    if (prev == nil) { // idnex == 0 删除第一个元素
        self.first = next;
    }else {
        prev.next = next;
    }
    
    if (next == nil) { // index == size 删除最后一个元素
        self.last = prev;
    }else {
        next.prev = prev;
    }
    
    self.size--;
    
    return node.element;
}


#pragma mark - 打印链表
- (NSString *)description {
    [super description];
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:[NSString stringWithFormat:@"size = %d",self.size]];
    
    if(self.size == 0) {
        [strM appendString:@" ["];
    }else {
        [strM appendString:@" [<->"];
    }
    
    LinkNode *node = self.first;
    for (int i = 0; i < self.size; i++) {
        if (i != 0) {
            [strM appendString:@"<->"];
        }
        [strM appendString:[NSString stringWithFormat:@"%@",node.element]];
        node = node.next;
    }
    
    [strM appendFormat:@"]"];
    return strM.copy;
}

@end
