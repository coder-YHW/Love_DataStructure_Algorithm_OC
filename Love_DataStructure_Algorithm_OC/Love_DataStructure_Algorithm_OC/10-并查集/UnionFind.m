//
//  UnionFind.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import "UnionFind.h"

@implementation UnionFind

#pragma mark - 构造函数
/** 构造函数 */
- (instancetype)initWithCapaticy:(int)capaticy {
    self = [super init];
    if (self) {
        self.parents = [NSMutableArray arrayWithCapacity:capaticy];
        for (int i = 0 ; i < self.parents.count ; i++) {
            self.parents[i] = [NSNumber numberWithInt:0];
        }
    }
    return self;
}


#pragma mark - 方法
/// 查找V所属的集合(根节点)
- (int)find:(int)v {
    NSLog(@"子类实现");
    return 0;
}

/// 合并v1, v2所在的集合
- (void)unionVal:(int)v1 val:(int)v2 {
    NSLog(@"子类实现");
}

/// 检查v1, v2是否属于同一个集合
- (BOOL)isSame:(int)v1 val:(int)v2 {
    return [self find:v1] == [self find:v2];
}


/// 判断是否越界
- (void)rangeCheck:(int)v {
    
    if (v < 0 || v >= self.parents.count) {
        NSLog(@"v is out of bounds");
        @throw [[NSException alloc] initWithName:@"out of bounds" reason:@"v is out of bounds" userInfo:nil];
    }
}


@end
