//
//  Recursion.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 递归➕迭代算法
@interface Recursion : NSObject


//MARK: - 求和问题1 - 递归法
- (int)sum1:(int)n;
//MARK:   求和问题2 - 迭代法
- (int)sum2:(int)n;


//MARK: - 斐波那契数列1 - 递归法
- (int)fib1:(int)n;
//MARK:   斐波那契数列2 - 变量法
- (int)fib2:(int)n;
//MARK:   斐波那契数列3 - 栈法
- (int)fib3:(int)n;


//MARK: - 上楼梯问题1  - 递归法
- (int)step1:(int)n;
//MARK: - 上楼梯问题2  - 迭代法
- (int)step2:(int)n;


//MARK: - 汉诺塔问题  - 递归法 (没法优化)
- (void)hanoi:(int)n a:(NSString *)a b:(NSString *)b c:(NSString *)c;

@end

NS_ASSUME_NONNULL_END
