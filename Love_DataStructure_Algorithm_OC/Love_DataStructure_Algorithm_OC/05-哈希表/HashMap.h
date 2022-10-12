//
//  HashMap.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//


#import "Map.h"
#import "HashNode.h"
/** 实现打印二叉树：
 * 1、遵守MJBinaryTreeInfo协议
 * 2、实现MJBinaryTreeInfo协议方法
*/
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

/// 哈希表 - 不能有比较器 - key为普通对象
@interface HashMap : Map <MJBinaryTreeInfo>


#pragma mark - 初始化 - HashNode  - 子类可以重写
/** 初始化 - HashNode  - 子类可以重写*/
- (HashNode *)createNodeWithKey:(id)key value:(id)value parent:(nullable HashNode *)parent;


#pragma mark - 子类重写 - 修复链表性质
/** 删除度为2的节点 node */
- (void)fixRemoveNode1:(HashNode *)node replace:(HashNode *)replaceNode;
/** 删除度为1或0的节点 node */
- (void)fixRemoveNode2:(HashNode *)node;


#pragma mark - 打印HashMap
- (void)printHashMap;

@end

NS_ASSUME_NONNULL_END
