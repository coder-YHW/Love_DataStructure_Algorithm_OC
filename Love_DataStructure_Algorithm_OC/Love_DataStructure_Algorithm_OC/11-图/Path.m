//
//  Path.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import "Path.h"

@implementation Path

#pragma mark - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        self.weight = 0.0;
        self.edgeInfos = [NSMutableArray array];
    }
    return self;
}


#pragma mark - isEqual➕compare ➕ hash
- (NSComparisonResult)compare:(Edge *)edge {
    
    if (self.weight > edge.weight) {
        return  NSOrderedDescending;
    }else if (self.weight < edge.weight) {
        return NSOrderedAscending;
    }else {
        return NSOrderedSame;
    }
}


#pragma mark - 打印
- (NSString *)description {
    [super description];
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:[NSString stringWithFormat:@"weight:%.2f 路径：[", self.weight]];

    for (Edge *edge in self.edgeInfos) {
        [strM appendString:[NSString stringWithFormat:@"%@->%@:%.2f, ", edge.from.value, edge.to.value, edge.weight]];
    }

    [strM appendString:@"]"];
    return strM.copy;
}

@end
