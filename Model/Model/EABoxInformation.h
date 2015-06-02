/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
#import "WirelessGeneral.h"
#import "DeviceGeneral.h"
@class TaskList;

/**
 * @class EABoxInformation
 * @brief 魔盒信息
 * @author 单宝华
 * @date 2014-12-2
 */
@interface EABoxInformation : NSObject<EAObjectGeneral, WirelessGeneral, DeviceGeneral>

/// @brief 任务列表
@property (strong, nonatomic) TaskList *taskList;

/// @brief 开关
@property (assign, nonatomic) BOOL powerOn;

@end
