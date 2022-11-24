//
//  QuickSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "QuickSort.h"

@implementation QuickSort


/// 快速排序 = 轴点分割 ➕ 轴点排序
/// 快速排序 - 逐渐将每一个元素都转换成轴点元素
/// 时间复杂度O(nlogn)  空间复杂度O(logn)
/// 最坏时间复杂度O(n^2)  全是逆序对的时候性能最差
//MARK: - 快速排序
- (void)sortAction {
    [self pivotDivide:0 end:(int)self.dataArray.count];
}


//MARK: 轴点分割
/**
 * 1、从序列[begin, end)范围内，随机选择一个轴点元素pivot
 * 2、利用pivot将序列分割成2个子序列
 * （将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
 */
- (void)pivotDivide:(int)begin end:(int)end {
    if (end - begin < 2) { return; }
    
    // 1、从序列[begin, end)范围内，随机选择一个轴点元素pivot
    // 2、利用pivot将序列分割成2个子序列
    //（将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
    int pivot = [self pivotSort:begin last:end];
    
    // 3、递归对左右子序列 重复1、2操作，直到只剩下一个元素或者没有元素时，不再排序。
    [self pivotDivide:begin end:pivot];
    [self pivotDivide:pivot+1 end:end];
}

//MARK: 轴点排序
/**
 * 1、为防止出现完全逆序的数组，在排序之前，随机交换一个数据到第一个位置。
 * 2、随机交换完首元素之后，选择第一个元素作为轴点元素pivot
 * 3、利用pivot将序列分割成2个子序列
 *（将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
 * 4、左右反复扫描 交换元素位置 保持3的性质
 */
- (int)pivotSort:(int)first last:(int)last {
    
    // 1、为防止出现完全逆序的数组，导致快速排序的性能很差。主要是因为每次都是取第一个元素作为标志位。
    // 在排序之前，随机交换一个数据到第一个位置。
    int radomIndex = (int)arc4random_uniform(last - first) + first; // [first last)之间随机整数
    [self swapIndex1:radomIndex index2:first];
    
    // 2、随机交换完首元素之后，选择第一个元素作为轴点元素pivot
    id pivotVal = self.dataArray[first];
    int begin = first;
    int end = last - 1; // 注意：last - 1 [first, last) 左闭右开区间
    
    // 3、利用pivot将序列分割成2个子序列
    //（将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
    // 4、左右反复扫描 交换元素位置 保持3的性质
    while (begin < end) { // begin < end
        
        while (begin < end) {
            // 4.1、从右往左扫描 <-
            if ([self cmpElement1:pivotVal element2:self.dataArray[end]] < 0) { // 轴点元素 < 右边元素 ： end--
                end--;  // 扫描方向不变 收缩右边界
            }else {     // 轴点元素 >= 右边元素 : 调换位置
                self.dataArray[begin] = self.dataArray[end];
                begin++;// 扫描方向改变 收缩左边界
                break;
            }
        }

        while (begin < end) {
            // 4.2、从左往右扫描 ->
            if ([self cmpElement1:pivotVal element2:self.dataArray[begin]] > 0) { // 轴点元素 > 左边元素 ： begin++
                begin++; // 扫描方向部变 收缩左边界
            }else {      // 轴点元素 <= 左边元素 : 调换位置
                self.dataArray[end] = self.dataArray[begin];
                end--;   // 扫描方向改变 收缩右边界
                break;
            }
        }
    }
    
    // 4.3、将轴点元素放入最终位置
    self.dataArray[begin] = pivotVal;
    // 返回轴点元素最终位置
    return begin; // begin = end
}

@end
