//
//  MergeSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "MergeSort.h"

/// 归并排序
/// 时间复杂度O(nlogn)
@implementation MergeSort {
    NSMutableArray *leftArray;
}


- (void)sortAction {
    
    leftArray = [NSMutableArray array];
    
    int mid = (int)self.dataArray.count >> 1;
    for (int i = 0 ; i < mid ; i++) {
        leftArray[i] = self.dataArray[i];
    }
    
    [self sortRange:0 end:(int)self.dataArray.count];
}


/// 对 [begin, end) 范围的数据进行归并排序
- (void)sortRange:(int)begin end:(int)end {
    
    if (end - begin < 2) { return; }
    
    int mid = (begin + end) >> 1;
    [self sortRange:begin end:mid];
    [self sortRange:mid end:end];
    [self mergeAction:begin mid:mid end:end];
}


/// 将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
- (void)mergeAction:(int)begin mid:(int)mid end:(int)end {
    
    // 1.1、左边数组索引 - 从原数组左边部份拷贝出来的新数组
    int leftIndex = 0;
    int leftEnd = mid - begin;
    // 1.2、右边数组索引 - 原数组右边部份
    int rigtnIndex = mid;
    int rightEnd = end;
    // 1.3原整个数组索引
    int dataArrayIndex = begin;
    
    // 2、备份左边数组
    for (int i = leftIndex ; i < leftEnd ; i++ ) {
        leftArray[i] = self.dataArray[i+begin];
    }
    
    // 3、右边数组跟左边数组比较 - 右比左小-顺序可以保证稳定性
    while (leftIndex < leftEnd)  { // 1.1、左边的排序完 右边的可以不用移动了
        
        // 3.1、右边的排序完 左边的会继续覆盖完
        if (rigtnIndex < rightEnd && [self cmpElement1:self.dataArray[rigtnIndex] element2:leftArray[leftIndex]] < 0) {
            // 2.1、右边的小 拿右边数组的值去覆盖dataArray
            self.dataArray[dataArrayIndex] = self.dataArray[rigtnIndex];
            rigtnIndex += 1;
            dataArrayIndex += 1;
        }else {
            // 3.2、左边的小 拿左边数组的值去覆盖dataArray
            self.dataArray[dataArrayIndex] = leftArray[leftIndex];
            leftIndex += 1;
            dataArrayIndex += 1;
        }
    }
}

@end
