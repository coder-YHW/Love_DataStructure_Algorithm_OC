//
//  LinkedList.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//  

#import "LinkedList.h"

@implementation LinkedList

/**
 * 清除所有元素
 */
- (void)clear {
    self.size = 0;
    self.first = nil;
}

/**
 * 查看元素的索引
 */
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

/** 获取index位置对应的节点对象 */
- (LinkNode *)nodeOfIndex:(int)index {
    if ([self rangeCheck:index]) {
        return nil;
    }
    
    LinkNode *node = self.first;
    for (int i = 0; i < index; i++) {
        node = node.next;
    }
    
    return node;
}

- (id)get:(int)index {
    return [self nodeOfIndex:index].element;
}

- (id)set:(int)index element:(id)element {
    if([self rangeCheck:index]) {
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
    if([self rangeCheckForAdd:index]) {
        return;
    }
    
    if (index == 0) { // 1、没有前驱节点 ：添加第一个节点 或者 在头部插入节点
        // 1、第一根线：self.first指向第一个节点 利用self.first创建新节点
        // 2、第二根线：将self.first指向新创建的节点
        self.first = [[LinkNode alloc] initWithElement:element next:self.first];

    } else { // 2、有前驱节点 ：在中间 或着 尾部插入节点
        // 1、第一根线：找到前驱节点 利用前驱节点的.next 创建新节点
        // 2、第二根线：将前驱节点的.next 指向新创建的节点
        LinkNode *prevNode = [self nodeOfIndex:index - 1];
        prevNode.next = [[LinkNode alloc] initWithElement:element next:prevNode.next];

    }
    
    self.size++;
}

// 删除索引为index的节点
- (id)remove:(int)index {
    if([self rangeCheck:index]) {
        return nil;
    }
    
    LinkNode *node;
    if (index == 0) { // 删除首节点
        // 1、第一根线：被删除的节点是self.first
        // 2、第二根线：将self.first指向self.first.next
        node = self.first;
        self.first = self.first.next;
    } else { // 删除其他节点
        // 1、第一根线：找到node的前驱节点prev  此时prev.next就是被删除的节点
        // 2、第二根线：将前驱节点的prev.next 指向node.next
        LinkNode *prev = [self nodeOfIndex:(index - 1)];
        node = prev.next;
        prev.next = node.next;
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
        [strM appendString:@" [->"];
    }
    
    
    LinkNode *node = self.first;
    for (int i = 0; i < self.size; i++) {
        if (i != 0) {
            [strM appendString:@"->"];
        }
        [strM appendString:[NSString stringWithFormat:@"%@",node.element]];
        node = node.next;
    }
    
    [strM appendFormat:@"]"];
    return strM.copy;
}

@end
