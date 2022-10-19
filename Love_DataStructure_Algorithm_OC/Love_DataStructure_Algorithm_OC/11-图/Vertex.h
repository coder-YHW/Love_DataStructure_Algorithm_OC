//
//  Vertex.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import <Foundation/Foundation.h>
#import "HashSet.h"

NS_ASSUME_NONNULL_BEGIN
/// 顶点
@interface Vertex : NSObject

#pragma mark - 属性

/** value*/
@property (nonatomic,strong) id value;
/** inEdges - 入度的边s - 多条无序*/
@property (nonatomic,strong) HashSet *inEdges;
/** outEdges - 出度的边s - 多条无序*/
@property (nonatomic,strong) HashSet *outEdges;


#pragma mark - 构造函数
- (instancetype)initVertexWithVal:(id)val;

@end

NS_ASSUME_NONNULL_END
