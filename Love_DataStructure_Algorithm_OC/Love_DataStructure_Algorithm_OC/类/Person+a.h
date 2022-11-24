//
//  Person+a.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/11/15.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN
//MARK: - 给分类扩展属性
@interface Person (a)

@property (nonatomic,assign) CGFloat weight;
@property (nonatomic,strong) NSString *job;

@end

NS_ASSUME_NONNULL_END
