//
//  ArrayList.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/12.
//  

#import "ArrayList.h"

static int kDefaultCapacity = 10;   // 默认动态数组元素数量为10个 分配10个内存空间

@implementation ArrayList {
    NSMutableArray *elements;
}

#pragma mark - 初始化
- (instancetype)init {
    return [self initWithCapaticy:kDefaultCapacity];
}

- (instancetype)initWithCapaticy:(int)capaticy {
    self = [super init];
    if (self) {
        capaticy = capaticy < kDefaultCapacity ? kDefaultCapacity : capaticy;
        elements = [NSMutableArray arrayWithCapacity:capaticy];
        for (int i = 0 ; i < capaticy; i++) {
            // 默认用NSNull占位
            [elements addObject:[NSNull null]];
        }
        self.size = 0;
    }
    return self;
}

#pragma mark - override
/** 清空所有元素 */
- (void)clear {
    for (int i = 0; i < self.size; i++) {
        // 删除之后置为NSNull占位
        elements[i] = [NSNull null];
    }
    self.size = 0;
}

/** 获取index位置的元素 */
- (id)get:(int)index {
    if([self rangeCheck:index]){
        return nil;
    }
    
    return elements[index];
}

/** 设置index位置的元素 */
- (id)set:(int)index element:(id)element {
    if([self rangeCheck:index]) {
        return nil;
    }
    
    id old = elements[index];
    elements[index] = element;
    
    return old;
}

/** 查看元素的索引*/
- (int)indexOfElement:(id)element {
    
    if (element == nil) {
        
        for (int i = 0; i < self.size; i++) {
            if (elements[i] == nil) {
                return i;
            }
        }
        
    } else {
        
        for (int i = 0; i < self.size; i++) {
            if ([elements[i] isEqual:element]) {
                return i;
            }
        }
    }
    
    return Default_NotFound;
}

#pragma mark - 添加删除
/** 在index位置插入一个元素 */
- (void)add:(int)index element:(id)element {
    if([self rangeCheckForAdd:index]) {
        return;
    }
    
    // 扩容检测
    [self ensureCapacity:self.size + 1];
    
    // index位置后面的值依次往后移动一位 - 注意移动顺序
    for (int i = self.size; i > index; i--) {
        elements[i] = elements[i - 1];
    }
    
    // 插入新值
    elements[index] = element;
    // 索引++
    self.size++;
}

/** 删除index位置的元素 */
- (id)remove:(int)index {
    if ([self rangeCheck:index]) {
        return nil;
    }
    
    // index位置后面的值依次往前移动一位 - 注意移动顺序
    id old = elements[index];
    for (int i = index + 1; i < self.size; i++) {
        elements[i - 1] = elements[i];
    }

    // 删除之后置为NSNull占位
    elements[(self.size - 1)] = [NSNull null];
    // 索引--
    self.size--;
    
    return old;
}

#pragma mark - 动态数组扩容➕动态数组缩容
/**动态数组扩容**/
- (void)ensureCapacity:(int)capacity {
    int oldCapacity = (int)elements.count;
    if (oldCapacity >= capacity) {
        return;
    }
    
    // 新容量为旧容量的1.5倍
    int newCapacity = oldCapacity + oldCapacity * 0.5;
    NSMutableArray *newElements = [NSMutableArray arrayWithCapacity:newCapacity];
    for (int i = 0; i < newCapacity; i++) {
        // 默认用NSNull占位
        [newElements addObject:[NSNull null]];
    }
    
    // 旧值设回
    for (int i = 0; i < self.size; i++) {
        newElements[i] = elements[i];
    }
    elements = newElements;

    NSLog(@"扩容为:%d",newCapacity);
}

/**动态数组缩容**/


#pragma mark - 打印
- (NSString *)description {
    [super description];
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:[NSString stringWithFormat:@"size = %d",self.size]];
    [strM appendString:@", ["];
    
    for (int i = 0; i < elements.count; i++) {
        if (i != 0) {
            [strM appendString:@", "];
        }
        [strM appendString:[NSString stringWithFormat:@"%@",elements[i]]];
    }
    
    [strM appendString:@"]"];
    return strM.copy;
}

@end
