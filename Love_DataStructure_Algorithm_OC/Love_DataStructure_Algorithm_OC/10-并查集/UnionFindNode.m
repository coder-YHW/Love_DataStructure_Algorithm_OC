//
//  UnionFindNode.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFindNode.h"

@implementation UnionFindNode

#pragma mark - 构造函数
- (instancetype)initWitVal:(id)val {
    self = [super init];
    if (self) {
        self.value = val;
        self.parent = self;  // 一开始-默认父节点是自己
        self.rank = 1;
    }
    return self;
}

#pragma mark - isEqual➕compare ➕ hash
- (BOOL)isEqual:(id)object {
 
    // 如果指向同一个对象或者均为nil则认为相等
    if (self == object) return YES;
    
    // 当object不为nil，且是本类的实例时：
    if (object && [object isMemberOfClass:[self class]]) {
        
        UnionFindNode *another = object;
        if ([self.value isEqual:another.value]) {
            return  YES;
        }
    }
    
    return  NO;
}

- (NSComparisonResult)compare:(UnionFindNode *)node {
    
    if (self.value > node.value) {
        return  NSOrderedDescending;
    }else if (self.value < node.value) {
        return NSOrderedAscending;
    }else {
        return NSOrderedSame;
    }
}

- (NSUInteger)hash {
    // 对关键属性的hash值进行位或运算作为hash值
    NSUInteger hashCode = [self.value hash];
    return  hashCode ^ (hashCode * 31);
}

@end
