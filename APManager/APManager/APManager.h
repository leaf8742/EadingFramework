/**
 * @file
 * @author 单宝华
 * @date 2013-07-28
 * @copyright 福建一丁芯智能技术有限公司大连分公司
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * @class APManager
 * @brief 路由信息管理类
 * @author 单宝华
 * @date 2013-07-28
 */
@interface APManager : NSObject

/// @brief 单例
+ (APManager*)sharedInstance;

/// @brief NSData类型的IP地址转换
- (NSString *)displayAddressForAddress:(NSData *) address;

/// @brief 本地IP地址
- (NSString *)getIPAddress;

/// @brief 子网掩码 subnet mask
- (NSString *)getNetmask;

/// @brief 目标IP地址，broadcast
- (NSString *)getDstaddr;

/// @brief 目标IP地址，broadcast
- (NSString *)getBroadcast;

/// @brief SSID
- (NSString *)ssidForConnectedNetwork;

/// @brief 网关地址
- (NSString *)getGatewayAddress;

@end
