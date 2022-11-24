//
//  Student.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/11/16.
//

#import "Student.h"
#import <objc/runtime.h>

// 全局变量4-不同文件里可以定义同名静态全局变量
static NSInteger cellWidth = 20;

@implementation Student


//MARK: - Runtime - 消息机制

//MARK: 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {

    if (sel == @selector(msg0)) {
        // 获取方法编码参数
        Method method = class_getInstanceMethod(self, @selector(other));
        // 动态添加方法
        class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
        // 返回YES 表示已处理
        return YES;
    }

    return [super resolveInstanceMethod:sel];
}

// 动态添加方法实现
- (void)other {
    NSLog(@"runtime消息机制-动态方法解析");
    
    // super相关面试题
    assert([self class] == [Student class]);
    assert([self superclass] == [NSObject class]);
    
    assert([super class] == [Student class]);
    assert([super superclass] == [NSObject class]);
    
//    NSLog(@"%@--%@--%@--%@",a,b,c,d);
}

//MARK: 消息重定向
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(msg1)) {

        // 返回Persond对象（Persond对象有msg1方法的实现）
        return [[Person alloc] init];
    }

    return [super forwardingTargetForSelector:aSelector];
}

//MARK: 方法签名
// 1、获取方法签名
// 方法签名：NSMethodSignature主要是方法的返回值和参数的类型信息的记录。
// methodSignatureForSelector：获取类方法或实例方法的签名；
// 也可以用instanceMethodSignatureForSelector：获取实例方法的签名；
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(msg2)) {
        // 获取方法编码参数（Person对象有）
        Method method = class_getInstanceMethod([Person class], @selector(other));
        // 获取方法签名
        return [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
    }

    return [super methodSignatureForSelector:aSelector];
}

// 1、处理方法签名
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 方法一：Person
    // 1.1、改变消息的SEL - 只要方法签名一样
    anInvocation.selector = @selector(other);
    // 1.2、改变消息接受者的Target - 只要这个对象有SEL方法
    [anInvocation invokeWithTarget:[[Person alloc] init]];
    
    // 方法二：self
    // 1.1、改变消息的SEL - 只要方法签名一样
//    anInvocation.selector = @selector(flyGame);
//    // 1.2、改变消息接受者的Target - 只要这个对象有SEL方法
//    [anInvocation invokeWithTarget:self];
}

- (void)flyGame{
    NSLog(@"我要飞翔追逐梦想！");
}

//MARK: - 全局变量
- (void)test {
    // 全局变量3-在Student.m里使用这个全局变量
//    cellHeight = 200.0;
//    NSLog(@"%.2f--%@--%ld", cellHeight, cellName,cellWidth);
    
    NSMutableString *n = [NSMutableString stringWithString:@"123"];
    
    self.name = n;
    
    [self.name appendString:@"4"];
    
    NSLog(@"%@--%@",self.name, n);
}


//MARK: - 指针常量 和 常量指针
- (void)test1 {
    // 指针常量
//        int a = 10, b = 20;
//        int * const p = &a;
//        *p = b; // p指向的地址是一定的，但其内容可以修改
//        NSLog(@"%d", *p); // 打印结果20

    
    // 常量指针
//        int a = 10, b = 20;
//        const int *p = &a;
//        p = &b; // 指针可以指向其他地址，但是内容不可以改变
//        NSLog(@"%d", *p); // 打印结果20
    
//        int m = 10;  // 变量var
//        const int n = 20; // 常量let-必须在定义的同时初始化
//
//        const int *p1 = &m;  // 常量指针 - 指针指向的内容不可改变
//        int * const p2 = &m; // 指针常量 - 指针不可以指向其他的地方
//
//        p1 = &n; // 正确
//        p2 = &n; // 错误，p2不能指向其他地方
//
//        *p1 = 3; // 错误，p1不能改变指针内容
//        *p2 = 4; // 正确
//
//        int *p3 = &n;        // 错误，n是常量-常量地址不能赋值给普通指针
//        const int * p4 = &n; // 正确，n是常量-常量地址只能赋值给常量指针

//        int * const p5; // 错误，指针常量定义时必须初始化
//        p5 = &m;        // 错误，指针常量不能在定义后赋值
//
//        int * const p6 = &n; // 正确-指针常量定义时必须初始化
//        *p6 = 8;             // 正确-指针常量可以修改指向的内容
//
//        const int * p7; // 正确-常量指针
//        p7 = &m;        // 正确-常量指针可以在定义后赋值
//
//        // 指向“常量”的指针常量，具有常量指针和指针常量的特点
//        // 指针内容不能改变，也不能指向其他地方，定义同时要进行初始化
//        const int * const p8 = &m;
//        *p8 = 5; // 错误，不能改变指针内容
//        p8 = &n; // 错误，不能指向其他地方
}

@end
