//
//  TrieNode.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HashMap;

@interface TrieNode : NSObject

#pragma mark - 属性
/** parent */
@property (nonatomic,strong) TrieNode *parent;
/** children */
@property (nonatomic,strong) HashMap  *children;
/** character - 节点对应的字符 */
@property (nonatomic,strong) NSString *character; 
/** word 是否为单词的结尾（是否为一个完整的单词）*/
@property (nonatomic,assign) BOOL word;
/** value - word为yes时 单词对应的value */
@property (nonatomic,strong,nullable) id value;


#pragma mark - 构造函数
/**构造函数 - 需要parent**/
- (instancetype)initWithParent:(nullable TrieNode *)parent;

@end

NS_ASSUME_NONNULL_END
