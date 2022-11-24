//
//  HeapSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/16.
//

#import "HeapSort.h"

@interface HeapSort ()


/// 堆排序 - 选择排序进阶版
/// 堆排序 = 原地建堆 ➕ 对堆排序 ➕ 下滤操作
/// 堆排序 - 平均、最坏、最好复杂度O(nlogn)    空间复杂度O(1)
/// /// 稳定排序
@property (nonatomic, assign) int heapCount;

@end

@implementation HeapSort

//MARK: - 堆排序
- (void)sortAction {
    
    self.heapCount = (int)self.dataArray.count;
    
    //MARK:  1、原地建堆
    // 1.对序列进行原地建堆（构建大顶堆）
    int lastIndex = (self.heapCount >> 1) - 1; // 对所有非叶子结点 进行自下而上的下滤
    for (int i = lastIndex; i >= 0; i--) { // 0 <= i <= (self.heapCount/2 - 1)
        // 对i位置下滤
        [self siftDown:i];
    }
    
    //MARK: 2、对堆排序（交换堆顶元素与末尾元素）
    // 2.调整堆结构（交换堆顶元素与末尾元素-排序）
    while (self.heapCount > 1) { //  self.heapCount > 1
        // 2.1、交换堆顶元素和尾部元素
        [self swapIndex1:0 index2:self.heapCount-1];
        // 2.2、堆的元素数量减1
        self.heapCount -- ;
        // 2.3、对0位置进行一次siftDown操作
        [self siftDown:0];
    }
}
    
//MARK:  3、下滤操作
/// 下滤
- (void)siftDown:(int)index {
    
    // 0、保存value的值
    id value = self.dataArray[index];
    int half = self.heapCount >> 1;

    // 1、非叶子结点（能够下滤的前提是非叶子结点）
    while (index < half) {

        // 2、找出当前节点较大的子节点
        // 2.1、左子节点索引 （2*index + 1）
        int childIndex = (index << 1) + 1;
        id childVal = self.dataArray[childIndex];
        
        // 2.2、右子节点索引 （2*index + 2）
        int rightIndex = childIndex + 1;
        
        // 2.3、选出左右子节点最大的那个
        if (rightIndex < self.heapCount) { // 算出来的索引要小于数组长度 否则会越界
            
            if ([self cmpElement1:self.dataArray[rightIndex] element2:childVal] > 0) { // 右子节点大 就替换child
                childIndex = rightIndex;
                childVal = self.dataArray[rightIndex];
            }
        }
        
        // 3.1、如果当节点比较大的子节点大，直接返回
        if ([self cmpElement1:value element2:childVal] >= 0) {
            break;
        }
        
        // 3.2、如果当节点比较大的子节点小，交换当前节点与这个较大的子节点
        self.dataArray[index] = childVal;
        // 3.3、重复上述操作
        index = childIndex;
    }
    // 4、将node的值赋值到其索引位置
    self.dataArray[index] = value;
}

@end
