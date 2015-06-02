/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
#import "WirelessGeneral.h"
#import "DeviceGeneral.h"

/**
 * @class CameraInformation
 * @brief  Wi-Fi摄像头
 * @author 单宝华
 * @date 2014-12-2
 */
@interface CameraInformation : NSObject<EAObjectGeneral, WirelessGeneral, DeviceGeneral>

/// @brief 用户名
@property (strong, nonatomic) NSString *account;

/// @brief 密码
@property (strong, nonatomic) NSString *passwd;

/// @brief uid
@property (strong, nonatomic) NSString *uid;

/// @brief 备注
@property (strong, nonatomic) NSString *remark;

/// @brief 地点
@property (strong, nonatomic) NSString *place;

@end
