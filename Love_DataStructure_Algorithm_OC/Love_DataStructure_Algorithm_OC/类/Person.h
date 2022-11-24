//
//  Person.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/11/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <NSCopying,NSMutableCopying>

@property (nonatomic,copy)   NSString *name;

@property (nonatomic,strong) NSString *age;

//MARK: - 分类实现多继承
/**
 * 分类实现多继承
 1）在主类Person中声明method、methodA、methodB方法
 2）在主类Person中实现method （主类实现B和C共有方法）
 3）在主类Person的分类a中实现methodA（分类实现会覆盖主类实现-methodA由a实现）
 4）在主类Person的分类b中实现methodB（分类实现会覆盖主类实现-methodB由b实现）
 此时：在主类Person、Person的分类a、Person的分类b中
 都可以调用方法method、methodA、methodB方法(注意避免循环调用)
 */
- (void)method;
- (void)methodA;
- (void)methodB;

- (void)msg0;
- (void)msg1;
- (void)msg2;
- (void)other;

@end

NS_ASSUME_NONNULL_END
