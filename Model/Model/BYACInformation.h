/**
 * @file
 * @author 单宝华
 * @date 2015-04-02
 * @copyright 福建一丁芯智能技术有限公司
 */
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
#import "WirelessGeneral.h"
#import "DeviceGeneral.h"
#import "Common.h"

@class BoxTask;

/**
 * @class BYACInformation
 * @brief 空调控制板
 * @author 单宝华
 * @date 2015-04-02
 */
@interface BYACInformation : NSObject<EAObjectGeneral, WirelessGeneral, DeviceGeneral>

/// @brief 开关机
@property (assign, nonatomic) BOOL powerOn;

/// @brief 设定温度
@property (assign, nonatomic) NSInteger temperature;

/// @brief 环境温度
@property (assign, nonatomic) NSInteger environmentTemp;

/// @brief 摆风
@property (assign, nonatomic) BOOL swing;

/// @brief 睡眠模式
@property (assign, nonatomic) BOOL sleep;

/// @brief 风速
@property (assign, nonatomic) kAirConditionerFanSpeed fanSpeed;

/// @brief 模式
@property (assign, nonatomic) kAirConditionerMode mode;

/// @brief 任务
@property (strong, nonatomic) BoxTask *task;

/// @brief 解析数字
- (NSInteger)modeString;

/// @brief 更新数据
- (void)updateMode:(NSInteger)mode;

/// @brief 更新任务
- (void)updateTask:(NSDictionary *)response;

@end
