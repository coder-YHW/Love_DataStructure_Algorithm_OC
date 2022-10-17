//
//  HeapSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/16.
//

#import "HeapSort.h"

@interface HeapSort ()


/// 堆排序 - 选择排序进阶版
/// 堆排序 - 平均、最坏、最好复杂度O(nlogn)    空间复杂度O(1)
@property (nonatomic, assign) int heapCount;

@end

@implementation HeapSort


- (void)sortAction {
    
    self.heapCount = (int)self.dataArray.count;
    
    // 1、创建堆 - 自下而上的下滤
    int lastIndex = (self.heapCount >> 1) - 1;
    for (int i = lastIndex; i >= 0; i--) { // 0 <= i <= (self.heapCount/2 - 1)
        // 对i位置下滤
        [self siftDown:i];
    }
    
    // 2、交换堆顶元素和尾部元素
    while (self.heapCount > 1) { //  self.heapCount > 1
        // 交换堆顶元素和尾部元素
        [self swapIndex1:0 index2:self.heapCount-1];
        // 堆大小-1
        self.heapCount -- ;
        // 对0位置下滤
        [self siftDown:0];
    }
}
    
    
- (void)siftDown:(int)index {
    
    // 0、保存value的值
    id value = self.dataArray[index];
    int half = self.heapCount >> 1;

    // 1、必须保证index位置是非叶子节点
    while (index < half) { // 必须保证index位置是非叶子节点

        // 左子节点索引 （2*index + 1）
        int childIndex = (index << 1) + 1;
        id childVal = self.dataArray[childIndex];
        
        // 右子节点索引 （2*index + 2）
        int rightIndex = childIndex + 1;
        
        // 2、选出左右子节点最大的那个
        if (rightIndex < self.heapCount) { // 算出来的索引要小于数组长度 否则会越界
            
            if ([self cmpElement1:self.dataArray[rightIndex] element2:childVal] > 0) { // 右子节点大 就替换child
                childIndex = rightIndex;
                childVal = self.dataArray[rightIndex];
            }
        }
        
        // 3、与其最大的那个子节点比较大小 value >= child 就停止while循环
        if ([self cmpElement1:value element2:childVal] >= 0) { // 注意：··     此处的index已经不是最初value对应的index了
            break;
        }
        
        // 4、value < child 继续下滤
        // 4.1、将子节点存放到index位置
        self.dataArray[index] = childVal;
        // 4.2、更新index
        index = childIndex;
    }
    
    // 5、将node的值赋值到其索引位置
    self.dataArray[index] = value;
}

@end
