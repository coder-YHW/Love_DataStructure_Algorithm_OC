//
//  LinkHashNode.h
//  Love_DataStructure_Algorithm_OC
//
//  Created by 余衡武 on 2022/10/10.
//

#import "HashNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinkHashNode : HashNode

/** next */
@property (nonatomic,strong) LinkHashNode *next;
/** prev */
@property (nonatomic,strong) LinkHashNode *prev;

@end

NS_ASSUME_NONNULL_END
