//
//  BubbleSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/16.
//

#import "BubbleSort.h"

/// 冒泡排序
/// 平均、最坏复杂度O(n^2)  最好时间复杂度O(n) 空间复杂度O(1)
/// 稳定排序
#pragma mark - BubbleSort
@implementation BubbleSort
/*
 * 1、比较两个相邻的元素。如果第一个比第二个大，就交换他们两个。
 * 2、对每一对相邻元素执行同样的操作，从开始第一对到结尾的最后一对。一趟扫描完毕，最后的元素应该会是最大的数。
 * 3、针对所有的元素重复以上的步骤，除了最后一个。
 * 4、持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
 * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
 * 比较次数：406 交换次数：224 耗时：0.0011131763458251953
 */
- (void)sortAction {
    
    for(int end = ((int)self.dataArray.count-1) ; end > 0 ; end--) {
        
        for(int begin = 1 ; begin <= end ; begin++) {
            
            int cmp = [self cmpIndex1:begin index2:begin-1];
            if (cmp < 0) {
                [self swapIndex1:begin index2:begin-1];
            }
        }
    }
}

@end


#pragma mark - BubbleSort1 - 外层优化
///（如果排序过程中 已经有序 可以提前结束for循环）
@implementation BubbleSort1
/*
 * 当发现在某一趟排序中没有发生交换，则说明排序已经完成，所以可以在此趟排序后提前结束排序。在每趟排序前设置flag，当其未发生改变时，终止算法；
 * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
 * 比较次数：400 交换次数：224 耗时：0.0007848739624023438
 */
- (void)sortAction {
    
    for(int end = ((int)self.dataArray.count-1) ; end > 0 ; end--) {
        
        BOOL sorted = YES; // 1、假定sorted = YES
        
        for(int begin = 1 ; begin <= end ; begin++) {
            
            int cmp = [self cmpIndex1:begin index2:begin-1];
            if (cmp < 0) {
                [self swapIndex1:begin index2:begin-1];
                
                sorted = NO; // 2、更新sorted = NO
            }
        }
        
        if (sorted) { break; } // 3、提前结束for循环
    }
}

@end


#pragma mark - BubbleSort2 - 内层优化
///（如果排序过程中 已经有序 可以提前结束for循环）
@implementation BubbleSort2
/*
 *  每趟排序中，最后一次发生交换的位置后面的数据均已有序，所以我们可以记住最后一次交换的位置来减少排序的趟数。
 * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
 * 比较次数：406 交换次数：209 耗时：0.0007090568542480469
 */
- (void)sortAction {
    
    for(int end = ((int)self.dataArray.count-1) ; end > 0 ; end--) {
        
        int sortedIndex = 1; // 1、假定sortedIndex = 1
        
        for(int begin = 1 ; begin <= end ; begin++) {
            
            int cmp = [self cmpIndex1:begin index2:begin-1];
            if (cmp < 0) {
                [self swapIndex1:begin index2:begin-1];
                
                sortedIndex = begin; // 2、更新sortedIndex = begin
            }
        }
        
        end = sortedIndex; // 3、减少for循环范围
    }
}

@end
