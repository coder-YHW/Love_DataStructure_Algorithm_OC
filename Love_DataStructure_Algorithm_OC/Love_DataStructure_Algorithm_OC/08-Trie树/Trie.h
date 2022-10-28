//
//  Trie.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 前缀树、字典树、单词查找树 （多叉树）
/// 时间复杂度低   空间复杂度高 （有待优化）
@interface Trie : NSObject

#pragma mark - 方法
/**元素数量**/
- (int)size;

/**元素是否为空*/
- (bool)isEmpty;

/**清空*/
- (void)clear;

/**查找字符串对应的value*/
- (NSString *)get:(NSString *)key;

/**是否包含字符串key**/
- (bool)contains:(NSString *)key;

/**添加一个字符串**/
- (id)add:(NSString *)key value:(id)value;

/**删除一个字符串*/
- (id)remove:(NSString *)key;

/**是否包含前缀prefix**/
- (bool)starsWith:(NSString *)prefix;

@end

NS_ASSUME_NONNULL_END
