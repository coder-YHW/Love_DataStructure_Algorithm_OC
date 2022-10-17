//
//  Sort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/16.
//

#import "Sort.h"

@interface Sort ()

#pragma mark - 属性
/// 比较次数
@property (nonatomic,assign)  int cmpCount;
/// 交换次数
@property (nonatomic,assign)  int swapCount;
/// 耗时
@property (nonatomic,assign)  double time;

@end

@implementation Sort
#pragma mark - 方法
- (NSMutableArray *)sortedWithArray:(NSMutableArray *)array {
    if (array.count < 2) { return array; }
    
    self.cmpCount = 0;
    self.swapCount = 0;
    
    self.dataArray = array;
    
    double begin = [[NSDate date] timeIntervalSince1970];
    [self sortAction];
    double end = [[NSDate date] timeIntervalSince1970];
    
    self.time = end - begin;
    
    HLog(@"比较次数：%d 交换次数：%d 耗时：%.6f", self.cmpCount, self.swapCount, self.time);
    
    return self.dataArray;
}

#pragma mark - 子类实现
- (void)sortAction {
    NSLog(@"Must Override");
}


#pragma mark - 辅助方法
/*
 * 根据索引比较
 * 返回值等于0，代表 array[i1] == array[i2]
 * 返回值小于0，代表 array[i1] < array[i2]
 * 返回值大于0，代表 array[i1] > array[i2]
 */
- (int)cmpIndex1:(int)index1 index2:(int)index2 {
    return [self cmpElement1:self.dataArray[index1] element2:self.dataArray[index2]];
}

/// 直接比较值
- (int)cmpElement1:(id)element1 element2:(id)element2 {
    
    self.cmpCount++;
    
    int e1 = [element1 intValue];
    int e2 = [element2 intValue];
    
    return e1 - e2;
}

/// 交换值
- (void)swapIndex1:(int)index1 index2:(int)index2 {
    
    self.swapCount++;
    
    int element1 = [self.dataArray[index1] intValue];
    int element2 = [self.dataArray[index2] intValue];
    
    self.dataArray[index1] = [NSNumber numberWithInt:element2];
    self.dataArray[index2] = [NSNumber numberWithInt:element1];
}


@end
