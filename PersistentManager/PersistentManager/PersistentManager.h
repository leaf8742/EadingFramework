/**
 * @file
 * @author leaf_8742@163.com
 * @date 2013/12/26
 */
#import <CoreData/CoreData.h>

/**
 * @class PersistentManager
 * @brief 数据库存储类
 * @author leaf_8742@163.com
 * @date 2013/12/06
 */
@interface PersistentManager : NSObject

+ (PersistentManager *)sharedInstance;

/// @brief 存储上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/// @brief 同步到数据库
- (void)saveContext;

@end
