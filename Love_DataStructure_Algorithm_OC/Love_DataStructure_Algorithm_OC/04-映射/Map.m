//
//  Map.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "Map.h"

@implementation Map

/// 所有key
- (NSMutableArray *)allkeys {
 
    NSMutableArray *keys = [NSMutableArray array];
    
    [self traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
        
        if (key != nil) {
            [keys addObject:key];
        }
    }];
    
    return keys;
}


///  所有values
- (NSMutableArray *)allValues {
    
    NSMutableArray *values = [NSMutableArray array];
    
    [self traversalWithBlock:^(id  _Nonnull key, id  _Nonnull value) {
        
        if (key != nil) {
            [values addObject:value];
        }
    }];
    
    return values;
}

@end
