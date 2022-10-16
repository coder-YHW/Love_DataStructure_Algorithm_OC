//
//  LinkHashNode.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/10.
//

#import "HashNode.h"

NS_ASSUME_NONNULL_BEGIN

// HashNode的基础上维护元素添加顺序 使得遍历结果是遵从添加顺序的
@interface LinkHashNode : HashNode

/** next */
@property (nonatomic,strong) LinkHashNode *next;
/** prev */
@property (nonatomic,strong) LinkHashNode *prev;

@end

NS_ASSUME_NONNULL_END
