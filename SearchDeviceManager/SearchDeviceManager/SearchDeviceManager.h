/**
 * @file
 * @author 单宝华
 * @date 2014-11-26
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const FoundDevice;

/**
 * @class SearchDeviceManager
 * @brief 搜索设备管理类
 * @author 单宝华
 * @date 2014-11-26
 */
@interface SearchDeviceManager : NSObject

/// @brief 查找魔盒
+ (void)sendEABOX;

/// @brief 查找Wi-Fi灯
+ (void)sendEALight;

/// @brief 查找插排
+ (void)sendEASOCKET;

/// @brief 查找小芒果
+ (void)sendMango;

/// @brief 查找空调主控板
+ (void)sendBYAC;

/// @brief 启用FoundDevice通知
+ (void)startNotifier;

/// @brief 禁用FoundDevice通知
+ (void)stopNotifier;

@end
