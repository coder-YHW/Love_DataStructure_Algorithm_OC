//
//  Person+a.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/11/15.
//

#import "Person+a.h"
#import <objc/runtime.h>

@interface Person (a)

@end

@implementation Person (a)
@dynamic weight;
@dynamic job;


- (void)setWeight:(CGFloat)weight {
    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)weight {
    NSNumber *obj = objc_getAssociatedObject(self, @selector(weight));
    return [obj floatValue];
}

- (void)setJob:(NSString *)job {
    objc_setAssociatedObject(self, @selector(job), job, OBJC_ASSOCIATION_COPY);
}

- (NSString *)job {
    NSString *obj = objc_getAssociatedObject(self, @selector(job));
    return obj;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (void)methodA {
    NSLog(@"PersonA-实现");
    [self methodB];
}

#pragma clang diagnostic pop

@end
