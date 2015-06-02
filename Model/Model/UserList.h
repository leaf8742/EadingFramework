/**
 * @file
 * @author 单宝华
 * @date 2015-01-27
 */
#import <Foundation/Foundation.h>

@class UserAuthority;

/**
 * @class UserList
 * @brief 用户列表
 * @author 单宝华
 * @date 2015-01-27
 */
@interface UserList : NSObject

/// @brief 用户列表
@property (strong, nonatomic) NSMutableSet *users;

/// @brief 根据mobile和email查找用户，如果查找不到，新建一个返回
- (UserAuthority *)userWithMobile:(NSString *)mobile email:(NSString *)email;

@end
