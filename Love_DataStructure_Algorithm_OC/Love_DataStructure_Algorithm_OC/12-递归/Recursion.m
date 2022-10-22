//
//  Recursion.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/22.
//

#import "Recursion.h"
#import "Stack.h"

@implementation Recursion

//MARK: - 求和问题1 - 递归法
/**
 * 求和问题
 * 求1，2，3，4...n  个数的和
 * 时间复杂度O(n)  空间复杂度O(n)
 * 递归的空间复杂度 = 递归深度 * 每次调用所需的辅助空间
 */
- (int)sum1:(int)n {
    // 0、边界条件
    if (n <= 1) { return 1; }
    
    // 2、n + sun(n-1)
    return n + [self sum1:n-1];
}

//MARK:   求和问题2 - 迭代法
/**
 * 求和问题
 * 求1，2，3，4...n  个数的和
 * 时间复杂度O(n) 空间复杂度O(1)
 */
- (int)sum2:(int)n {
    // 0、边界条件
    if (n <= 1) { return 1; }
    
    // 1、前n-1个数之和
    int sum = 1;
    // 2、从2开始for循环
    //    for i in 2...n {
    for (int i = 2 ; i <= n ; i++) {
        sum = sum + i;
    }
    
    return sum;
}

//MARK: - 斐波那契数列1 - 递归法
/**
 * 斐波那契数(自身=前两个数的和)
 * 1, 1, 2, 3, 5, 8, 13, 21, 34
 * 时间复杂度: T(n) = T(n - 1) + T(n - 2) + O(1), 即O(2^n)
 * 空间复杂度O(n)
 * 递归的空间复杂度 = 递归深度 * 每次调用所需的辅助空间
 */
- (int)fib1:(int)n {
    // 0、边界条件
    if (n <= 2) { return 1; }
    
    // 1、递归调用
    return [self fib1:n-2] + [self fib1:n-1];
}

//MARK:   斐波那契数列2 - 变量法
/**
 * 斐波那契数(自身=前两个数的和)
 * 非递归, 变量计算
 * 时间复杂度O(n) 空间复杂度O(1)
 */
- (int)fib2:(int)n {
    // 0、边界条件
    if (n <= 2) { return 1; }
    
    // 1、用两个变量first、second保存前两个数的值
    int first = 1;
    int second = 1;
    // 2、从3开始for循环
    for (int i = 3 ; i <= n ; i++) {
        second = first + second;
        first = second - first;
    }
    
    return second;
}


//MARK:   斐波那契数列3 - 栈法
/**
 * 斐波那契数(自身=前两个数的和)
 * 非递归, 栈
 */
- (int)fib3:(int)n {
    // 0、边界条件
    if (n <= 2) { return 1; }
    
    // 1、入栈：用栈保存0跟1位置的值
    Stack *stack = [[Stack alloc] init];
    [stack push:[NSNumber numberWithInt:1]];
    [stack push:[NSNumber numberWithInt:1]];
    // 2、从3开始for循环
    for (int i = 3 ; i <= n ; i++) {
        // 3、出栈：first➕second
        int first = [[stack pop] intValue];
        int second = [[stack pop] intValue];
        
        // 4、入展：用栈保存前两个数的值 再将first,
        [stack push:[NSNumber numberWithInt:first]];
        [stack push:[NSNumber numberWithInt:first + second]];
    }
    
    return [[stack pop] intValue];
}


//MARK: - 上楼梯问题1 - 递归法
/**
 * 上楼梯（跳台阶）
 * 楼梯有 n阶台阶，上楼可以一步上 1 阶，也可以一步上2阶，走完n 阶台阶共有多少种不同的走法？
 * 1、假设口阶台阶有 f(n) 种走法，第1步有2种走法、如果上1阶，那就还剩n一1阶，共f(n一1)种走法
 * 2、如果上2阶，那就还剩n一2阶，共f(n一2)种走法
 * 3、所以 f(n) = f(n-1) + f(n-2）
 * 1  1
 * 2  2
 * 3  3
 * 4  5
 */
- (int)step1:(int)n {
    
    // 0、边界条件
    if (n <= 2) { return n; } // 注意：此处有点不一样
    
    // 1、递归调用
    return [self step1:n-2] + [self step1:n-1];
}



//MARK: - 上楼梯问题2  - 迭代法
/**
 * 上楼梯（跳台阶）
 * 楼梯有 n阶台阶，上楼可以一步上 1 阶，也可以一步上2阶，走完n 阶台阶共有多少种不同的走法？
 * 1、假设口阶台阶有 f(n) 种走法，第1步有2种走法、如果上1阶，那就还剩n一1阶，共f(n一1)种走法
 * 2、如果上2阶，那就还剩n一2阶，共f(n一2)种走法
 * 3、所以 f(n) = f(n-1) + f(n-2）
 */
- (int)step2:(int)n {
    // 0、边界条件
    if (n <= 2) { return n; } // 注意：此处有点不一样
    
    // 1、用两个变量first、second保存前两个数的值
    int first = 1;
    int second = 2;
    // 2、从3开始for循环
    for (int i = 3 ; i <= n ; i++) {
        second = first + second;
        first = second - first;
    }
    
    return second;
}


//MARK: - 汉诺塔问题  - 递归法 (没法优化)
/**
 * 汉诺塔问题
 * 将n个盘子从第一根柱子挪动到第三根柱子上
 * 要求1:每次只能移动一个盘子
 * 要求2:大盘子只能放在小盘子下面
 * 打印每个盘子的移动过程
 * 时间复杂度: T(n) = T(n - 1) + T(n - 2) + O(1), 即O(2^n)
 * 空间复杂度O(n)
 */
- (void)hanoi:(int)n a:(NSString *)a b:(NSString *)b c:(NSString *)c {
    
    if (n == 1) {
        // 0、出口 - 将编号为1的盘子从第1根柱子挪动到第3根柱子上
        [self movelog:1 a:a b:b c:c];
        return;
    }
    
    // 1、将n-1个盘子从第1根柱子挪动到第2根柱子上
    [self hanoi:n-1 a:a b:c c:b];
    
    // 2、将编号为n的盘子从第1根柱子挪动到第3根柱子上
    [self movelog:n a:a b:b c:c];
    
    // 3、将n-1个盘子从第2根柱子挪动到第3根柱子上
    [self hanoi:n-1 a:b b:a c:c];
}

- (void)movelog:(int)n a:(NSString *)a b:(NSString *)b c:(NSString *)c {
    NSLog(@"将第%d号盘子 从第%@根柱子 移动到第%@根柱子", n, a, c);
}

@end
