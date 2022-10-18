//
//  ShellSort.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/17.
//

#import "ShellSort.h"

@implementation ShellSort


/// 希尔排序
- (void)sortAction {
    
    // 1、创建步长序列
    NSMutableArray *stepSequence = [self shellStepSequence];
//    let stepSequence = sedgewickStepSequence()
    
    // 2、分成step列进行排序 对每一列进行插入排序
    for (int i = 0 ; i < stepSequence.count ; i++ ) {
        [self stepSort:i];
    }
}


/// 2、分成step列进行排序 -对每一列进行插入排序  索引映射：index = col  + row*step
- (void)stepSort:(int)step {
    
    for (int col = 0 ; col < step ; col++) { // 对每列row中元素进行插入排序
        
        // 3、插入排序1 = step + col
        int begin = col + step;
        while (begin < self.dataArray.count) { // 插入排序
            
            int current = begin;
            while (current > col && [self cmpIndex1:current index2:(current - step)] < 0) {
                
                [self swapIndex1:current index2:current - step];
                
                current -= step;
            }
            
            // 4、下一个
            begin += step; // 相当于begin ++
        }
    }
}


/// 3、希尔本人提出的步长序列（ n / 2^k ）
- (NSMutableArray *)shellStepSequence {
    
    NSMutableArray *stepSequence = [NSMutableArray array];
    
    int step = (int)self.dataArray.count >> 1;
    if (step > 0) {
        
        [stepSequence addObject:[NSNumber numberWithInt:step]];
        
        step = step >> 1;
    }
    
    return stepSequence;
}


/// 目前最好的步长序列 - sedgewick 套用数学公式
- (NSMutableArray *)sedgewickStepSequence {
    
    NSLog(@"做了解即可");
    return [NSMutableArray array];
}


@end
