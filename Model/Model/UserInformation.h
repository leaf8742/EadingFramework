/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "Common.h"

@class EAObjectList;

/**
 * @class UserInformation
 * @brief 用户信息
 * @author 单宝华
 * @date 2014-12-2
 */
@interface UserInformation : NSObject

/// @brief 对象列表
@property (retain, nonatomic) EAObjectList *objectList;

/// @brief 登录帐户类型
@property (assign, nonatomic) kAccountType accountType;

/// @brief 邮箱
@property (retain, nonatomic) NSString *email;

/// @brief 手机
@property (retain, nonatomic) NSString *mobile;

/// @brief 用户名
@property (retain, nonatomic) NSString *name;

/// @brief 性别(male, female)
@property (retain, nonatomic) NSString *gender;

/// @brief 密码
@property (retain, nonatomic) NSString *passwd;

/// @brief 自动登录
@property (assign, nonatomic) BOOL autoSignIn;

/// @brief 记住密码
@property (assign, nonatomic) BOOL rememberPasswd;

/// @brief sessionID
@property (retain, nonatomic) NSString *sessionID;

/// @brief 推送
@property (retain, nonatomic) NSString *deviceTokenString;

/// @brief 配色方案
@property (retain, nonatomic) NSString *colorScheme;

/// @brief 是否绑定
@property (assign, nonatomic) BOOL binded;

/// @brief 用户头像
@property (retain, nonatomic) NSString *picture;

/// @brief 缓存头像
@property (readonly, nonatomic) NSString *mementoPicture;

/// @brief 根据mobile初始化UserInformation
- (id)initWithMobile:(NSString *)mobile;

/// @brief 根据email初始化UserInformation
- (id)initWithEmail:(NSString *)email;

/// @brief 单例
+ (instancetype)sharedInstance;

/// @brief 根据手机号码查询用户，如果查找不到，返回nil
+ (instancetype)getUserWithMobile:(NSString *)mobile;

/// @brief 根据邮箱查询用户，如果查找不到，返回nil
+ (instancetype)getUserWithEmail:(NSString *)email;

/// @brief 初始化
- (void)initialize;

- (void)reloadObjectList;

@end
