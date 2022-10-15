//
//  LinkNode.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 链表节点
@interface LinkNode : NSObject

#pragma mark - 属性
/** element */
@property (nonatomic,assign,nullable) id element;
/** next */
@property (nonatomic,strong,nullable) LinkNode *next;
/** prev */
@property (nonatomic,strong,nullable) LinkNode *prev;


#pragma mark - 构造函数
/**单向节点-构造函数**/
- (instancetype)initWithElement:(id)element next:(nullable LinkNode *)next;

/**双向节点-构造函数**/
- (instancetype)initWithPrev:(nullable LinkNode *)prev element:(id)element next:(nullable LinkNode *)next;



@end

NS_ASSUME_NONNULL_END
