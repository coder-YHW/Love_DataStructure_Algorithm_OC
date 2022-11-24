//
//  Person.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/11/15.
//

#import "Person.h"

// 全局变量1-在Person.m里定义一个全局变量
static NSInteger cellWidth = 10; // 全局变量4-不同文件里可以定义同名静态全局变量
CGFloat cellHeight = 100.0;
NSString const *cellName = @"cellName";

@interface Person ()
{
    CGFloat height;
}

@end

@implementation Person

//MARK: - 消息重定向
- (void)msg1 {
    NSLog(@"runtime消息机制-消息重定向");
    
    // isKindOfClass和isMemberOfClass
    assert([Person isKindOfClass:[Person class]] == NO);
    assert([Person isKindOfClass:[NSObject class]] == YES);
    assert([NSObject isKindOfClass:[NSObject class]] == YES);
    
    assert([Person isMemberOfClass:[Person class]] == NO);
    assert([NSObject isMemberOfClass:[NSObject class]] == NO);
}

- (void)msg2 {
   NSLog(@"runtime消息机制-方法签名");
}

- (void)other {
    NSLog(@"runtime消息机制-方法签名");
}


//MARK: - NSCopying,NSMutableCopying
/**
* 1.类直接继承自NSObject，无需调用[super copyWithZone:zone]
* 2.父类没有实现copy协议，子类实现了copy协议，子类无需调用[super copyWithZone:zone]
* 3.父类实现了copy协议，子类需要调用[super copyWithZone:zone]
* 4.copyWithZone方法中要调用[[[self class] allocWithZone:zone] init]来分配内存
* mutableCopy同理
*/

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Person *person = [[self class] allocWithZone:zone];
    person.name = [self.name mutableCopyWithZone:zone]; // 这是一个mutableCopy属性
    person.age = self.age; // age不可变
    person->height = height; // 这是私有变量
    return person;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    Person *person = [[self class] allocWithZone:zone];
    person.name = [self.name mutableCopyWithZone:zone]; // 这是一个mutableCopy属性
    person.age = self.age; // age不可变
    person->height = height; // 这是私有变量
    return person;
}

//MARK: - 分类实现多继承
- (void)method {
    NSLog(@"Person-实现");
}

- (void)methodA {
    NSLog(@"Person-分类实现");
}

- (void)methodB {
    NSLog(@"Person-分类实现");
}

- (void)stringCopy:(char *)strDestination strSource:(const char *)strSource {
    
}

@end
