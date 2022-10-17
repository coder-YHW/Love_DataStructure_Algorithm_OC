//
//  SelectionSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/16.
//

#import "SelectionSort.h"

/// 选择排序
/// 选择排序 - 平均、最坏、最好复杂度O(n^2)    空间复杂度O(1)
/// 非稳定排序
@implementation SelectionSort

- (void)sortAction {
    
    for(int end = ((int)self.dataArray.count-1) ; end > 0 ; end--) {
        
        int maxIndex = 0; // 1、假定最大值索引 = 0
        
        for(int begin = 1 ; begin <= end ; begin++) {
            
            int cmp = [self cmpIndex1:maxIndex index2:begin];  // 注意这一句
            if (cmp <= 0) {
                maxIndex = begin; // 2、更新最大值索引 = begin
            }
        }
        
        [self swapIndex1:maxIndex index2:end]; // 3、交换最大值索引与end的值
    }
}


@end
