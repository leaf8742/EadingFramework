/**
 * @file
 * @author 单宝华
 * @date 2013/12/24
 * @copyright 大连一丁芯智能技术有限公司
 */

/**
 * @class EasyLink
 * @brief EasLink配置
 * @author 单宝华
 * @date 2013/12/24
 */
@interface EasyLink : NSObject

/// @brief 单例
+ (EasyLink *)sharedInstance;

/// @brief 开始配置
- (void)startWithSSID:(NSString *)SSID password:(NSString *)passwd info:(NSString *)userInfo;

/// @brief 结束配置
- (void)stop;

@end
