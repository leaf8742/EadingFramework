/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>

/**
 * @protocol WirelessGeneral
 * @brief 无线协议
 * @author 单宝华
 * @date 2014-12-2
 */
@protocol WirelessGeneral <NSObject>

/// @brief ip地址
@property (strong, nonatomic) NSString *ip;

/// @brief ssid
@property (strong, nonatomic) NSString *ssid;

/// @brief 是否在同一局域网内
@property (readonly, assign, nonatomic, getter = isReady) BOOL ready;

@end

/**
 @synthesize ip = _ip;
 @synthesize ssid = _ssid;
 @synthesize ready = _ready;
*/