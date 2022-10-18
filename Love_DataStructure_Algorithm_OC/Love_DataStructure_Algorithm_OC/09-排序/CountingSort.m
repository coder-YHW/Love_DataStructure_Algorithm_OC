//
//  CountingSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "CountingSort.h"


/// 计数排序 - 对一定范围内的整数进行排序
/// 空间换时间
/// 时间复杂度 空间复杂度都是 O(n+k) k是整数的取值范围
/// 稳定排序
@implementation CountingSort


- (void)sortAction {
    if (self.dataArray.count < 2) { return; } // 对整数数组进行排序

    // 1、最大值、最小值
    id maxObj = self.dataArray[0];
    id minObj = self.dataArray[0];
    for (int i = 0 ; i < self.dataArray.count ; i++) {
        
        id obj = self.dataArray[i];
        
        if ([self cmpElement1:maxObj element2:obj] < 0) {
            maxObj = obj;
        }
        
        if ([self cmpElement1:minObj element2:obj] > 0) {
            minObj = obj;
        }
    }
    
    // 2、开辟内存空间存储次数 ：max - min + 1
    int max = [maxObj intValue];
    int min = [minObj intValue];
    NSMutableArray *counts = [NSMutableArray arrayWithCapacity:max - min + 1];
    for (int i = 0 ; i < max - min + 1 ; i++) {
        counts[i] = [NSNumber numberWithInt:0];
    }
        
    // 2.1、统计每个整数出现的次数 - 整数次数存储的索引是（objVal - min）
    for (id obj in self.dataArray) {
        int objVal = [obj intValue];
        
        int count = [counts[objVal - min] intValue];
        count ++;
        counts[objVal - min] = [NSNumber numberWithInt:count];
    }
    
    
    // 3、累加次数 - （把前面整数出现的次数累计到自己出现的次数上 更新counts数组）
    for (int i = 1 ; i < max - min + 1 ; i++) {
        int count1 = [counts[i - 1] intValue];
        int count2 = [counts[i] intValue];
        counts[i] = [NSNumber numberWithInt:(count1 + count2)];
    }
    
    // 4、从后往前遍历元素, 将objVal放到新有序数组newArray中的合适位置 （从右往左 <- 稳定性）
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:self.dataArray.count];\
    for (int i = 0 ; i < self.dataArray.count ; i++) {
        newArray[i] = [NSNumber numberWithInt:0];
    }
    
    for (int i = (int)self.dataArray.count - 1 ; i >= 0  ; i--) {
        int objVal = [self.dataArray[i] intValue]; // 反向遍历 取出val
        int count = [counts[objVal - min] intValue]; // val对应次数
        count -= 1; // 索引--
        counts[objVal - min] = [NSNumber numberWithInt:count]; // 更新counts
        newArray[count] = [NSNumber numberWithInt:objVal]; // 插入newArray对应位置
    }
    
    // 5、将有序数组newArray复制到array
    for (int i = 0 ; i < newArray.count ; i++) {
        self.dataArray[i] = newArray[i];
    }
    
}


@end
