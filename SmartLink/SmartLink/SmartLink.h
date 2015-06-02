/**
 * @file
 * @author 单宝华
 * @date 2014-01-07
 * @copyright 福建一丁芯智能技术有限公司
 */
#import <Foundation/Foundation.h>

/**
 * @class SmartLink
 * @brief SmartLink配置
 * @author 单宝华
 * @date 2014-01-07
 */
@interface SmartLink : NSObject

/// @brief 单例
+ (SmartLink *)sharedInstance;

/// @brief SmartLink开始发送密码，只发密码，模块会从收到的数据中提取出路由器的SSID
- (void)startWithPasswd:(NSString *)passwd;

/// @brief 停止发送
- (void)stop;

@end
