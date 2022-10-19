//
//  Edge.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import "Edge.h"

@implementation Edge

#pragma mark - 构造函数
- (instancetype)initEdgeFrom:(Vertex *)from to:(Vertex *)to {
    self = [super init];
    if (self) {
        self.from = from;
        self.to = to;
    }
    return self;
}

#pragma mark - isEqual ➕ hash
- (BOOL)isEqual:(id)object {
 
    // 如果指向同一个对象或者均为nil则认为相等
    if (self == object) return YES;
    
    // 当object不为nil，且是本类的实例时：
    if (object && [object isMemberOfClass:[self class]]) {
        
        Edge *another = object;
        if ([self.from isEqual:another.from] && [self.to isEqual:another.to]) {
            return  YES;
        }
    }
    
    return  NO;
}

- (NSUInteger)hash {
    // 对关键属性的hash值进行位或运算作为hash值
    NSUInteger hashCode1 = [self.from hash];
    NSUInteger hashCode2 = [self.to hash];
    return hashCode1 ^ hashCode2;
}

#pragma mark - 打印
- (NSString *)description {
    [super description];
    
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendString:@"边：Edge ["];
    
    [strM appendString:[NSString stringWithFormat:@"fromVertex:%@, ", self.from.value]];
    [strM appendString:[NSString stringWithFormat:@"toVertex:%@, ", self.to.value]];
    [strM appendString:[NSString stringWithFormat:@"weight:%.0f ", self.weight]];
    
    [strM appendString:@"]"];
    return strM.copy;
}

@end
