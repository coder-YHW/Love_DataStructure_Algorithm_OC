//
//  Vertex.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import "Vertex.h"

@implementation Vertex


#pragma mark - 构造函数
- (instancetype)initVertexWithVal:(id)val {
    self = [super init];
    if (self) {
        self.value = val;
        self.inEdges = [[HashSet alloc] init];
        self.outEdges = [[HashSet alloc] init];
    }
    return self;
}

#pragma mark - isEqual➕compare ➕ hash
- (BOOL)isEqual:(id)object {
 
    // 如果指向同一个对象或者均为nil则认为相等
    if (self == object) return YES;
    
    // 当object不为nil，且是本类的实例时：
    if (object && [object isMemberOfClass:[self class]]) {
        
        Vertex *another = object;
        if (self.value == another.value) { // 对象的值相等
            return  YES;
        }
        
//        if ([self.value isEqual:another.value]) { // 同一个对象
//            return  YES;
//        }
    }
    
    return  NO;
}

- (NSComparisonResult)compare:(Vertex *)vertex {
    return [self.value compare:vertex.value];
}

- (NSUInteger)hash {
    // 对关键属性的hash值进行位或运算作为hash值
    NSUInteger hashCode = [self.value hash];
    return  hashCode ^ (hashCode * 31);
}

#pragma mark - 打印
- (NSString *)description {
    [super description];
    
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendString:@"顶点：Vertex ["];
    
    [strM appendString:[NSString stringWithFormat:@"vertex:%@, ", self.value]];
    
    [strM appendString:@"]"];
    
    return strM.copy;
}

@end
