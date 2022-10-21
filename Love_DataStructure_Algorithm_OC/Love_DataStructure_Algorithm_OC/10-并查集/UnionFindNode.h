//
//  UnionFindNode.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 泛型并查集节点
@interface UnionFindNode : NSObject

#pragma mark - 属性

/** value*/
@property (nonatomic,strong) id value;
/** parent - 父节点*/
@property (nonatomic,strong) UnionFindNode *parent;
/** rank - 集合的树的高度*/
@property (nonatomic,assign) int rank;


#pragma mark - 构造函数
- (instancetype)initWitVal:(id)val;

@end

NS_ASSUME_NONNULL_END
