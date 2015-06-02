/**
 * @file
 * @author 单宝华
 * @date 2013/12/24
 * @copyright 大连一丁芯智能技术有限公司
 */

/**
 * @class SmartConnection
 * @brief SmartConnection配置
 * @author 单宝华
 * @date 2014/11/12
 */
@interface SmartConnection : NSObject

/// @brief 单例
+ (SmartConnection *)sharedInstance;

/// @brief 开始配置
- (void)startWithSSID:(NSString *)SSID password:(NSString *)passwd;

/// @brief 结束配置
- (void)stop;

@end
