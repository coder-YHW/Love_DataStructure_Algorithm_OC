//
//  HashNode.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/7.
//

#import "HashNode.h"

@implementation HashNode

#pragma mark - 构造方法
- (instancetype)initWithKey:(id)key value:(id)value parent:(nullable HashNode *)parent {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
        self.hashCode = [self getHashCodeFromKey:key]; // 保存key的hashCode 缓存起来 避免多次计算;
        self.parent = parent;
        self.color = HashNodeTypeRed;
    }
    return self;
}


#pragma mark - 通用接口
/** 是否是叶子节点 */
- (BOOL)isLeaf {
    return self.left == nil && self.right == nil;
}

/** 是否有两个子树 */
- (BOOL)hasTwoChildren {
    return self.left != nil && self.right != nil;
}

/** 是否是parent的左子树 */
- (BOOL)isLeftChild {
    return self.parent != nil && self == self.parent.left;
}

/** 是否是parent的右子树 */
- (BOOL)isRightChild {
    return self.parent != nil && self == self.parent.right;
}

/** 返回兄弟节点 */
- (HashNode *)sibling {
    if ([self isLeftChild]) {
        return self.parent.right;
    }
    
    if ([self isRightChild]) {
        return self.parent.left;
    }
    
    return nil;
}

#pragma mark - 把key哈希化成hashCode
/**把key哈希化成hashCode**/
- (int)getHashCodeFromKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    int hashCode = (int)[key hash]; // 1、哈希函数
    hashCode = hashCode ^ (hashCode >> 16); // 2、向右偏移16位, 做异或操作
    
    return hashCode;
}

@end
