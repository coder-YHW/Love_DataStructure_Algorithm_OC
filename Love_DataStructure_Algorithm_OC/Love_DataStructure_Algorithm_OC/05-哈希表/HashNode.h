//
//  HashNode.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**红黑树节点颜色*/
typedef NS_ENUM(NSInteger, HashNodeType) {
    HashNodeTypeRed       = 0,  // 0：红色 - 默认
    HashNodeTypeBlack     = 1,  // 1：黑色
};

@interface HashNode : NSObject

#pragma mark - 接口
/** key */
@property (nonatomic,strong) id key;
/** value */
@property (nonatomic,strong) id value;
/** key -> hashCode */
@property (nonatomic,assign) int hashCode;
/** color */
@property (nonatomic,assign) HashNodeType color;
/** left */
@property (nonatomic,strong,nullable) HashNode *left;
/** right */
@property (nonatomic,strong,nullable) HashNode *right;
/** parent*/
@property (nonatomic,strong,nullable) HashNode *parent;

#pragma mark - 构造函数
- (instancetype)initWithKey:(id)key value:(id)value parent:(nullable HashNode *)parent;


#pragma mark - 接口
/** 是否是叶子节点 */
- (BOOL)isLeaf;

/** 是否有两个子树 */
- (BOOL)hasTwoChildren;

/** 是否是parent的左子树 */
- (BOOL)isLeftChild;

/** 是否是parent的右子树 */
- (BOOL)isRightChild;

/** 返回兄弟节点 */
- (HashNode *)sibling;

@end

NS_ASSUME_NONNULL_END
