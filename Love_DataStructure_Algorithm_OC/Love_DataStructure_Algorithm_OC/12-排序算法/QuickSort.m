//
//  QuickSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "QuickSort.h"

@implementation QuickSort


/// 快速排序 - 逐渐将每一个元素都转换成轴点元素
- (void)sortAction {
    [self quickSort:0 end:(int)self.dataArray.count];
}


/**
 * 对 [begin, end) 范围的元素进行快速排序
 */
- (void)quickSort:(int)begin end:(int)end {
    if (end - begin < 2) { return; }
    
    // 1、构造出 [begin, end) 范围的轴点元素
    int pivotIndex = [self pivotIndex:begin last:end];
    
    // 2、对子序列再次快速排序
    [self quickSort:begin end:pivotIndex];
    [self quickSort:pivotIndex+1 end:end];
}

/**
 * 构造出 [begin, end) 范围的轴点元素
 * @return 轴点元素的最终位置
 * 为了避免分割出来的数列极度不均匀, 取一个随机的索引和第一个交换
 */
- (int)pivotIndex:(int)first last:(int)last {
    
    // 随机的索引和first交换 : arc4random_uniform(uint32_t)会随机返回一个0到上界之间（不含上界）的整数
    int radomIndex = (int)arc4random_uniform(last - first) + first; // [first last)之间随机整数
    [self swapIndex1:radomIndex index2:first];
    
    // 0、索引处理
    id pivotVal = self.dataArray[first];
    int begin = first;
    int end = last - 1; // 注意：last - 1
    
    // 1、左右扫描
    while (begin < end) { // begin < end
        
        while (begin < end) {
            // 1.1、从右往左扫描 <-
            if ([self cmpElement1:pivotVal element2:self.dataArray[end]] < 0) { // 轴点元素 < 右边元素 ： end--
                end--;
            }else { // 轴点元素 >= 右边元素 : 调换位置
                self.dataArray[begin] = self.dataArray[end];
                begin++;
                break;
            }
        }

        while (begin < end) {
            // 1.2、从左往右扫描 ->
            if ([self cmpElement1:pivotVal element2:self.dataArray[begin]] > 0) { // 轴点元素 > 左边元素 ： begin++
                begin++;
            }else { // 轴点元素 <= 左边元素 : 调换位置
                self.dataArray[end] = self.dataArray[begin];
                end--;
                break;
            }
        }
    }
    
    // 2、将轴点元素放入最终位置
    self.dataArray[begin] = pivotVal;
    // 返回轴点元素最终位置
    return begin; // begin = end
}

@end
