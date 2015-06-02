/**
 * @file
 * @author 单宝华
 * @date 2015-01-27
 */
#import <Foundation/Foundation.h>
#import "Common.h"

@class UserInformation;

/**
 * @class UserAuthority
 * @brief 用户权限类
 * @author 单宝华
 * @date 2015-01-27
 */
@interface UserAuthority : NSObject

/// @brief 用户信息
@property (strong, nonatomic) UserInformation *user;

/// @brief 权限
@property (assign, nonatomic) kAuthority authority;

@end
