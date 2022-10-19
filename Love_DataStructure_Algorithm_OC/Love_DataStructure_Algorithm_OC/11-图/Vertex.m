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
