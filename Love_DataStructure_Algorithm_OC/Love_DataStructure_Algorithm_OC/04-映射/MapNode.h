//
//  MapNode.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**红黑树节点颜色*/
typedef NS_ENUM(NSInteger, MapNodeType) {
    MapNodeTypeRed       = 0,  // 0：红色 - 默认
    MapNodeTypeBlack     = 1,  // 1：黑色
};

@interface MapNode : NSObject

#pragma mark - 属性
/** key */
@property (nonatomic,strong) id key;
/** value */
@property (nonatomic,strong) id value;
/** color */
@property (nonatomic,assign) MapNodeType color;
/** left */
@property (nonatomic,strong,nullable) MapNode *left;
/** right */
@property (nonatomic,strong,nullable) MapNode *right;
/** parent*/
@property (nonatomic,strong,nullable) MapNode *parent;

#pragma mark - 构造函数
- (instancetype)initWithKey:(id)key value:(id)value parent:(nullable MapNode *)parent;


#pragma mark - 辅助函数
/** 是否是叶子节点 */
- (BOOL)isLeaf;

/** 是否有两个子树 */
- (BOOL)hasTwoChildren;

/** 是否是parent的左子树 */
- (BOOL)isLeftChild;

/** 是否是parent的右子树 */
- (BOOL)isRightChild;

/** 返回兄弟节点 */
- (MapNode *)sibling;

@end

NS_ASSUME_NONNULL_END
