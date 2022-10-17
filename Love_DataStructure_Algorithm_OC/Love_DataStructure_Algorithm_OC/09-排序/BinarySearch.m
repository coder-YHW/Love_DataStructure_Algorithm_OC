//
//  BinarySearch.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "BinarySearch.h"

@implementation BinarySearch

/*
 * 二分搜索查找索引
 * 先记录待插入的元素
 * 头部有序数列中比待插入元素大的, 都向后挪动一个位置
 * 将待插入元素放到合适的位置
 * 比较次数：97 交换次数：0
 */


- (void)sortAction {
    
    for (int begin = 1 ; begin < self.dataArray.count ; begin++ ) {
        
        // 1、用二分搜索找到插入位置的ndex
        int insertindex = [self searchInsertIndex:begin];
        
        // 2、将[insertIndex begin) 范围内的元素往右移动一个位置
        id value = self.dataArray[begin];
        for (int i = begin-1 ; i >= insertindex ; i-- ) {
            self.dataArray[i+1] = self.dataArray[i];
        }
        self.dataArray[insertindex] = value;
    }
}


/// 二分搜索, 根据索引搜索
/// index之前的元素都是有序的
/// index代表新插入的元素
- (int)searchInsertIndex:(int)index {
    
    int begin = 0;
    int end = index;
    
    while (begin < end) {
        
        int mid = (begin + end) >> 1;
        
        if([self cmpIndex1:index index2:mid] < 0) { // index在mid左边
            end = mid;
        }else { // index在mid右边
            // 查找到最后面的相等的索引
            begin = mid + 1;
        }
    }
    
    return begin;
}

@end
