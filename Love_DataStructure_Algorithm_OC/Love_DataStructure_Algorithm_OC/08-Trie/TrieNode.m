//
//  TrieNode.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import "TrieNode.h"

@implementation TrieNode

- (instancetype)initWithParent:(nullable TrieNode *)parent {
    self = [super init];
    if (self) {
        self.parent = parent;
    }
    return self;
}

@end
