//
//  Edge.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/19.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

NS_ASSUME_NONNULL_BEGIN
/// 边
@interface Edge : NSObject

#pragma mark - 属性

/** weight - 权重*/
@property (nonatomic,assign) double weight;
/** from - 来的顶点*/
@property (nonatomic,strong) Vertex *from;
/** to - 去的顶点*/
@property (nonatomic,strong) Vertex *to;


#pragma mark - 构造函数
- (instancetype)initEdgeFrom:(Vertex *)from to:(Vertex *)to;

@end

NS_ASSUME_NONNULL_END
