/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
#import "WirelessGeneral.h"
#import "DeviceGeneral.h"

@class TaskList;

/**
 * @class EALightInformation
 * @brief  Wi-Fi灯
 * @author 单宝华
 * @date 2014-12-2
 */
@interface EALightInformation : NSObject<EAObjectGeneral, WirelessGeneral, DeviceGeneral>

/// @brief 颜色字典
@property (strong, nonatomic) NSMutableDictionary *colors;

/// @brief 解析颜色
@property (strong, nonatomic, readonly) UIColor *color;

/// @brief 开关
@property (assign, nonatomic) BOOL powerOn;

/// @brief 任务列表
@property (strong, nonatomic) TaskList *taskList;

@end
