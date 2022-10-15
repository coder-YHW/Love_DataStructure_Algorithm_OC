//
//  ArrayListUpgrade.m
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/8.
//


#import "ArrayListUpgrade.h"

static int kDefaultCapacity = 10;   // 默认动态数组元素数量为10个 分配10个内存空间

@interface ArrayListUpgrade ()

/**数组首元素索引 */
@property (nonatomic,assign) int front;

@end

@implementation ArrayListUpgrade {
    NSMutableArray *elements; // 动态数组
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
        self.front = 0;
    }
    return self;
}

#pragma mark - override
/** 清空所有元素 */
- (void)clear {
    for (int i = 0; i < self.size; i++) {
        // 索引映射
        int newIndex = [self getIndex:i];
        // 删除之后置为NSNull占位
        elements[newIndex] = [NSNull null];
    }
    self.size = 0;
    self.front = 0;
    
    // 动态数组缩容
    [self cutCapacity];
}

/** 获取index位置的元素 */
- (id)get:(int)index {
    if([self rangeCheck:index]){
        return nil;
    }
    
    // 索引映射
    int newIndex = [self getIndex:index];
    return elements[newIndex];
}

/** 设置index位置的元素 */
- (id)set:(int)index element:(id)element {
    if([self rangeCheck:index]) {
        return nil;
    }
    
    // 索引映射
    int newIndex = [self getIndex:index];
    id old = elements[newIndex];
    elements[newIndex] = element;
    
    return old;
}

/** 查看元素的索引*/
- (int)indexOfElement:(id)element {
    
    if (element == nil) {
        
        for (int i = 0; i < self.size; i++) {
            // 索引映射
            int newIndex = [self getIndex:i];
            if (elements[newIndex] == nil) {
                return i;
            }
        }
        
    } else {
        
        for (int i = 0; i < self.size; i++) {
            // 索引映射
            int newIndex = [self getIndex:i];
            if ([elements[newIndex] isEqual:element]) {
                return i;
            }
        }
    }
    
    return Default_NotFound;
}


/** 在index位置插入一个元素 */
- (void)add:(int)index element:(id)element {
    if([self rangeCheckForAdd:index]) {
        return;
    }
    
    // 扩容检测
    [self ensureCapacity:self.size + 1];
    
    // 索引映射
    int newIndex = [self getIndex:index]; // 当前index索引映射
    int lastIndex = [self getIndex:self.size]; // 最后一个元素索引映射 - 添加的lastIndex跟删除的lastIndex不一样
    
    if (newIndex == lastIndex) { // 1、往数组末尾插入元素
        
        // 插入新值
        elements[newIndex] = element;
        
    }else if(newIndex == self.front) { // 2、往数组开头插入元素

        // 索引映射
        newIndex = [self getIndex:(-1)];
        // 插入新值
        elements[newIndex] = element;
        // 更新首元素
        self.front = newIndex;
        
    }else { // 3、往数组中间插入元素
        
        // index位置后面的值依次往后移动一位 - 注意移动顺序
        for (int i = self.size; i > index; i--) {
            int curr = [self getIndex:(i)];
            int prev = [self getIndex:(i-1)]; // 不能curr-1 可能会为负数
            elements[curr] = elements[prev];
        }
        // 插入新值
        elements[newIndex] = element;
    }
    
    self.size++;
}

/** 删除index位置的元素 */
- (id)remove:(int)index {
    if ([self rangeCheck:index]) {
        return nil;
    }
    
    
    // 索引映射
    int newIndex = [self getIndex:index];
    int lastIndex = [self getIndex:(self.size-1)]; // 删除的lastIndex跟添加的lastIndex不一样
    id old = elements[newIndex];
    
   if (newIndex == lastIndex) { // 1、在数组末尾删除元素
        
        // 删除旧值
        elements[newIndex] = [NSNull null];
        
    }else if(newIndex == self.front) { // 2、在数组开头删除元素
        
        // 删除旧值
        elements[newIndex] = [NSNull null];
        // 索引映射
        newIndex = [self getIndex:(1)];
        // 更新首元素
        self.front = newIndex;
        
    }else { // 3、在数组中间删除元素
        
        // index位置后面的值依次往前移动一位 - 注意移动顺序
        for (int i = index + 1; i < self.size; i++) { // 范围：(index+1)..<count 赋值：elements[i-1] = elements[i];
            int curr = [self getIndex:(i-1)];
            int next = [self getIndex:(i)]; // 不能curr+1 可能会超过size
            elements[curr] = elements[next];
        }
        // 删除之后置为NSNull占位
        elements[lastIndex] = [NSNull null];
    }
    
    self.size--;
    
    // 动态数组缩容
    [self cutCapacity];
    
    return old;
}


#pragma mark - 动态数组索引映射 对i和index索引映射
/// 获取真正插入位置的索引  - 对i和index索引映射
- (int)getIndex:(int)index {
    
//    // 0、0 <= index < elements.count
//
//    // 1、往数组开头添加元素 index传-1 （循环队列）
//    index = self.front - 1;
//    if(index < 0) {
//        index = (int)elements.count + index;
//    }
//
//    // 2、往数组末尾添加元素 index传size（循环队列）
//    index = self.front + self.size;
//    if(index >= elements.count) {
//        index = index - (int)elements.count;
//    }
//
//    // 3、往数组中间插入元素 移动尽可能少的元素
//    // index不需要变化
    
    // 0 <= index < elements.count
    index = self.front + index;
    
    if(index < 0) { // index < 0
        index = index + (int)elements.count;
    }else if (index >= elements.count) { // index >= elements.count
        index = index - (int)elements.count;
    }
    
    return index;
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
        int index = [self getIndex:i];
        newElements[i] = elements[index];
    }
    elements = newElements;

    NSLog(@"扩容为:%d",newCapacity);
}

/**动态数组缩容**/
- (void)cutCapacity {
    
    int oldCapacity = (int)elements.count;
    int newCapacity = oldCapacity >> 1;
    if (newCapacity < kDefaultCapacity || newCapacity <= self.size) {
        return;
    }
    
    NSMutableArray *newElements = [NSMutableArray arrayWithCapacity:newCapacity];
    for (int i = 0; i < newCapacity; i++) {
        // 默认用NSNull占位
        [newElements addObject:[NSNull null]];
    }
    
    // 旧值设回
    for (int i = 0; i < self.size; i++) {
        int index = [self getIndex:i];
        newElements[i] = elements[index];
    }
    elements = newElements;
    
    NSLog(@"缩容为:%d",newCapacity);
}


#pragma mark - 越界查询没变化
- (void)outOfBounds:(int)index {
    NSLog(@"索引越界：index:%lu, size:%lu",(unsigned long)index,(unsigned long)self.size);
}

/**越界查询 - iindex < 0 || index >= _size */
- (bool)rangeCheck:(int)index {
    if (index < 0 || index >= self.size) {
        [self outOfBounds:index];
        return YES;
    }
    return NO;
}

/**add越界查询 - index < 0 || index > _size */
- (bool)rangeCheckForAdd:(int)index {
    if (index < 0  || index > self.size) {
        [self outOfBounds:index];
        return YES;
    }
    return NO;
}


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
