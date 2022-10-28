//
//  RadixSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "RadixSort.h"

/// 基数排序 - 擅长对整数（尤其是非负整数）进行排序
/// 依次对十位数、百位数、万位数.... 进行排序 （从低位到高位）
/// /// 空间换时间
/// 时间复杂度 空间复杂度都是 O(d*(n+k)) d是最大整数位数 k是进制
/// 稳定排序
@implementation RadixSort


- (void)sortAction {
    if (self.dataArray.count < 2) { return; } // 对整数数组进行排序

    // 1、最大值
    id maxObj = self.dataArray[0];
    for (int i = 0 ; i < self.dataArray.count ; i++) {
        id obj = self.dataArray[i];
        if ([self cmpElement1:maxObj element2:obj] < 0) {
            maxObj = obj;
        }
    }
    

    // 2、依次对十位数、百位数、万位数.... 进行排序 （从低位到高位）
    /// 个位数：dataArray[i] / 1 % 10
    /// 十位数：dataArray[i] / 10 % 10
    /// 百位数：dataArray[i] / 100 % 10
    /// 千位数：dataArray[i] / 1000 % 10
    /// 。。。
    
    int divider = 1;
    int maxInt = [maxObj intValue];
    while (divider <= maxInt) {
        [self insertSort:divider];
//        [self insertSort1:divider];
        divider = divider * 10;
    }
        
}

/// 计数排序 -  比较次数：29 交换次数：0
- (void)insertSort:(int)divider {
    // 1、最大值、最小值
    // 0～9
    
    // 2、开辟内存空间存储次数 ：max - min + 1
    NSMutableArray *counts = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0 ; i < 10 ; i++) {
        counts[i] = [NSNumber numberWithInt:0];
    }
    
    // 2.1、统计每个整数出现的次数 - 整数次数存储的索引是（objVal - min）
    for (id obj in self.dataArray) {
        int objVal = [obj intValue] / divider % 10;
        
        int count = [counts[objVal] intValue];
        count ++;
        counts[objVal] = [NSNumber numberWithInt:count];
    }
    
    // 3、累加次数 - （把前面整数出现的次数累计到自己出现的次数上 更新counts数组）
    for (int i = 1 ; i < counts.count ; i++) {
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
        int objVal = [self.dataArray[i] intValue] / divider % 10; // 反向遍历 取出val
        int count = [counts[objVal] intValue]; // val对应次数
        count -= 1; // 索引--
        counts[objVal] = [NSNumber numberWithInt:count]; // 更新counts
        newArray[count] = self.dataArray[i]; // 插入newArray对应位置
    }
    
    // 5、将有序数组newArray复制到array
    for (int i = 0 ; i < newArray.count ; i++) {
        self.dataArray[i] = newArray[i];
    }
}


/// 插入排序 - 比较次数：29  交换次数：412
- (void)insertSort1:(int)divider {
    
    for (int begin = 1 ; begin < self.dataArray.count ; begin++ ) {
        
        int current = begin;
        
        while (current > 0) {
            
            int value1 = [self.dataArray[current] intValue]/divider % 10;
            int value2 = [self.dataArray[current-1] intValue]/divider % 10;
            
            if ([self cmpElement1:[NSNumber numberWithInt:value1] element2:[NSNumber numberWithInt:value2]] < 0) {
                [self swapIndex1:current index2:current-1];
            }else { // 有序部分已经有序了
                break;
            }
        
            current--;
        }
    }
}


@end
