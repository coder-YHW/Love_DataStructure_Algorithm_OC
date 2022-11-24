//
//  Student.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 全局变量2-在Student.h里extern一个全局变量
extern CGFloat cellHeight;
extern NSString const *cellName;

@interface Student : NSObject

@property (nonatomic,strong) NSMutableString *name;


- (void)test;


- (void)msg0;
- (void)msg1;
- (void)msg2;
@end

NS_ASSUME_NONNULL_END
