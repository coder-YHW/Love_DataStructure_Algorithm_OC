//
//  LinkHashMap.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/10.
//

#import "HashMap.h"

NS_ASSUME_NONNULL_BEGIN

// HashMap的基础上维护元素添加顺序 使得遍历结果是遵从添加顺序的
/// 1、添加修复LinkHashMap性质 - 重写createNode构造函数
/// 2、删除修复LinkHashMap性质 - 重写fixLinkHashMapAfterRemove1和fixLinkHashMapAfterRemove2
/// 3、clear时 记得清空first和last指针
@interface LinkHashMap : HashMap

@end

NS_ASSUME_NONNULL_END
