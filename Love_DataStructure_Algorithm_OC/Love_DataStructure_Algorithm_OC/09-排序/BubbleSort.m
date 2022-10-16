//
//  BubbleSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/16.
//

#import "BubbleSort.h"

#pragma mark - BubbleSort
@implementation BubbleSort

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


#pragma mark - BubbleSort1 - 优化（如果排序过程中 已经有序 可以提前结束for循环）
@implementation BubbleSort1

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


#pragma mark - BubbleSort2 - 优化（如果排序过程中 已经有序 可以提前结束for循环）
@implementation BubbleSort2

- (void)sortAction {
    
    for(int end = ((int)self.dataArray.count-1) ; end > 0 ; end--) {
        
        int sortedIndex = 1; // 1、假定sortedIndex = 1
        
        for(int begin = 1 ; begin <= end ; begin++) {
            
            int cmp = [self cmpIndex1:begin index2:begin-1];
            if (cmp < 0) {
                [self swapIndex1:begin index2:begin-1];
            }
            
            sortedIndex = begin; // 2、更新sortedIndex = begin
        }
        
        end = sortedIndex; // 3、减少for循环范围
    }
}

@end
