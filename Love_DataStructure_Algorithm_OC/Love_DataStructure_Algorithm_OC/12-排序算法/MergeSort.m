//
//  MergeSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "MergeSort.h"

/// 归并排序 = 分割操作 ➕ 合并操作
/// 时间复杂度O(nlogn) 空间复杂度O(n)
@implementation MergeSort {
    NSMutableArray *leftArray;
}

//MARK: - 归并排序
- (void)sortAction {
    
    leftArray = [NSMutableArray array];
    
    int mid = (int)self.dataArray.count >> 1;
    for (int i = 0 ; i < mid ; i++) {
        // 此处只是创建一个长度是dataArray一半的辅助数组leftArray
        // 除了复用辅助数组的内存空间外 没有任何其他特殊含义
        leftArray[i] = self.dataArray[i];
    }
    
    [self divideAction:0 end:(int)self.dataArray.count];
}


//MARK: - 1、归并排序
/**
 * 一、divideAction-分割操作
 * 将 [begin, end) 范围的数据进分割成 [begin, mid) 与 [mid, end)两部分
 * 合并排序好之后的 [begin, mid) 与 [mid, end)两部分数据
 */
- (void)divideAction:(int)begin end:(int)end {
    // 递归基
    if (end - begin < 2) { return; }
    
    int mid = (begin + end) >> 1;
    [self divideAction:begin end:mid]; // 分割操作
    [self divideAction:mid end:end];   // 分割操作
    [self mergeAction:begin mid:mid end:end]; // 合并操作
}


//MARK: 2、合并操作
/**
 * 二、mergeAction - 合并操作
 * 将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
 * merge原理 跟 【88-合并两个有序数组】很相似
 */
- (void)mergeAction:(int)begin mid:(int)mid end:(int)end {
    
    // 1、将要合并的左边数组元素 从dataArray拷贝到leftArray中
    for (int i = 0 ; i < (mid-begin) ; i++ ) {
        leftArray[i] = self.dataArray[i+begin];
    }
    
    // 3、右边数组跟左边数组比较 - 右比左小-顺序可以保证稳定性
    int leftIndex = 0;    // 左边数组指针：在leftArray中的index：[0, mid-begin)
    int rigtnIndex = mid; // 右边数组指针：在dataArray中的index：[mid, end)
    int currIndex = 0;    // 插入位置指针：在dataArray中的index：[begin, end)
    
    while (leftIndex < (mid-begin))  { // 1.1、左边的排序完 右边的可以不用移动了
        
        // 3.1、右边的排序完 左边的会继续覆盖完
        if (rigtnIndex < end && [self cmpElement1:self.dataArray[rigtnIndex] element2:leftArray[leftIndex]] < 0) {
            // 2.1、右边的小 拿右边数组的值去覆盖dataArray
            self.dataArray[currIndex] = self.dataArray[rigtnIndex];
            rigtnIndex += 1;
            currIndex += 1;
        }else {
            // 3.2、左边的小 拿左边数组的值去覆盖dataArray
            self.dataArray[currIndex] = leftArray[leftIndex];
            leftIndex += 1;
            currIndex += 1;
        }
    }
}

@end
