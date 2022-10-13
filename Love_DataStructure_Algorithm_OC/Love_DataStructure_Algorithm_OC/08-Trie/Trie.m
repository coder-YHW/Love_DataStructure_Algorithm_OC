//
//  Trie.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "Trie.h"
#import "TrieNode.h"
#import "HashMap.h"

@implementation Trie {
    int size;
    TrieNode *root;
}

#pragma mark - overwrite
/**元素数量**/
- (int)size {
    return size;
}

/**元素是否为空*/
- (bool)isEmpty {
    return size == 0;
}

/**清空*/
- (void)clear {
    size = 0;
    root = nil;
}

/**根据字符串查找node**/
- (TrieNode *)nodeOfKey:(NSString *)key {
    [self keyCheck:key];
    
    TrieNode *node = root;
    int len = (int)key.length;
    for (int i = 0; i < len; i++) {
        if (node == nil || node.children == nil) {
            return nil;
        }
        NSString *c = [key substringWithRange:NSMakeRange(i, 1)];
        node = [node.children get:c];
    }
    return node;
}

/**是否包含前缀prefix**/
- (bool)starsWith:(NSString *)prefix {
    return [self nodeOfKey:prefix] != nil;
}

/**是否包含字符串key**/
- (bool)contains:(NSString *)key {
    TrieNode *node = [self nodeOfKey:key];
    return node != nil && node.word;
}

/**查找字符串对应value*/
- (NSString *)get:(NSString *)key {
    TrieNode *node = [self nodeOfKey:key];
    return (node != nil && node.word) ? node.value : nil;
}

/**添加一个字符串**/
- (id)add:(NSString *)key value:(id)value {
    [self keyCheck:key];
    
    // 1、创建根节点
    if (root == nil) {
        root = [[TrieNode alloc] initWithParent:nil];
    }
    
    TrieNode *node = root;
    int len = (int)key.length;
    // 2、遍历字符
    for (int i = 0; i < len; i++) {
        NSString *c = [key substringWithRange:NSMakeRange(i, 1)];
        // 3、根据字符获取子节点
        TrieNode *childNode = node.children == nil ? nil : [node.children get:c];
        // 3.1、子节点为空
        if (childNode == nil) {
            node.children = node.children == nil ? [[HashMap alloc] init] : node.children; //  node.children为空
            childNode = [[TrieNode alloc] initWithParent:node]; // [node.children get:c] 为空
            childNode.character = c;
            [node.children put:c value:childNode];
        }
        
        // 3.2、子节点不为空 - 根据字符继续往下查找
        node = childNode;
    }
    
    // 如果已经存在这个单词 - 覆盖
    if (node.word) {
        id oldValue = node.value;
        node.value = value;
        return oldValue;
    }
    
    // 新建一个单词
    node.word = true;
    node.value = value;
    size++;
    
    return nil;
}

/**删除一个字符串*/
- (id)remove:(NSString *)key {
    
    // 1、找到最后一个节点
    TrieNode *node = [self nodeOfKey:key];
    
    // 2、如果不是单词结尾,不用做任何处理
    if (node == nil || !node.word) { // 这个字符串不存在
        return nil;
    }
    
    // 3、size--
    size--;
    id oldValue = node.value;
    
    // 4、node如果还有子节点 只需要改变word为false value为nil
    if (node.children != nil && !node.children.isEmpty) {
        node.word = false;
        node.value = nil;
        return oldValue;
    }
    
    // 5、如果没有子节点 找到node的父节点 删除父节点字符对应的这个node
    TrieNode *parent = nil;
    while ((parent = node.parent) != nil) { // 5.1、父节点不为空
        
        [parent.children remove:node.character]; // 5.2、删除父节点字符对应的这个node
        
        if (parent.word || !parent.children.isEmpty) { // 5.3、一直往上直到 parent.word || !parent.children.isEmpty
            break;
        }
    }
    
    return oldValue;
}


#pragma mark - private
- (void)keyCheck:(NSString *)key {
    if (key == nil && key.length == 0) {
        [NSException raise:@"key must not be empty" format:@"%@",key];
    }
}

@end
