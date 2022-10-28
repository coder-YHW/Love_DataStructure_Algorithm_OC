//
//  InsertionSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "InsertionSort.h"

/// 插入排序
/// 插入排序 - 平均、最坏时间复杂度O(n^2)、最好时间复杂度O(n)    空间复杂度O(1)
/// 插入排序时间复杂度跟逆序对成正比关系
/// 稳定排序
@implementation InsertionSort

/*
 * 插入排序会将数列分为两个部分, 头部是已经排序好的, 尾部是待排序的部分
 * 从头开始扫描每一个元素, 只要比头部的数据小, 就插入到头部一个合适的位置
 * 比较次数：351 交换次数：204
 */
- (void)sortAction {
    
    for (int begin = 1 ; begin < self.dataArray.count ; begin++ ) {
        
        int current = begin;
        
        while (current > 0) {
            
            if([self cmpIndex1:current index2:current-1] < 0) {
                [self swapIndex1:current index2:current-1];
            }
            
            current--;
        }
    }
}

@end


/*
 * 插入排序会将数列分为两个部分, 头部是已经排序好的, 尾部是待排序的部分
 * 从头开始扫描每一个元素, 只要比头部的数据小, 就插入到头部一个合适的位置
 * 有序部分已经有序师 break
 * //比较次数：225 交换次数：204
 */
@implementation InsertionSort1

- (void)sortAction {
    
    for (int begin = 1 ; begin < self.dataArray.count ; begin++ ) {
        
        int current = begin;
        
        while (current > 0 && [self cmpIndex1:current index2:current-1] < 0) { // 有序部分已经有序了
            
            [self swapIndex1:current index2:current-1];
            
            current--;
        }
    }
}

@end


/*
 * 将交换改为挪动
 * 先记录待插入的元素
 * 头部有序数列中比待插入元素大的, 都向后挪动一个位置
 * 将待插入元素放到合适的位置
 * 比较次数：225 移动次数：204
 */
@implementation InsertionSort2

- (void)sortAction {
    
    for (int begin = 1 ; begin < self.dataArray.count ; begin++ ) {
        
        int current = begin;
        id value = self.dataArray[current];
        
        while (current > 0 && [self cmpElement1:value element2:self.dataArray[current-1]] < 0) { // 注意条件
            
            self.dataArray[current] = self.dataArray[current-1]; // 不交换 往后移动一个位置
            current--;
        }
        
        self.dataArray[current] = value;
    }
}

@end



/*
 * 二分搜索查找索引 只是减少了比较次数 依然要移动 时间复杂度依然是O(n^2)
 * 插入排序 - 平均、最坏时间复杂度O(n^2)、最好时间复杂度O(n)    空间复杂度O(1)
 * 先记录待插入的元素
 * 头部有序数列中比待插入元素大的, 都向后挪动一个位置
 * 将待插入元素放到合适的位置
 * 比较次数：97 交换次数：0
 */
@implementation InsertionSort3

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

