/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "TaskGeneral.h"
@class LightSignleTask;

/**
 * @class LightTask
 * @brief Wi-Fi灯任务
 * @author 单宝华
 * @dagte 2014-12-3
 */
@interface LightTask : NSObject<TaskGeneral>

/// @brief 开启任务
@property (strong, nonatomic) LightSignleTask *powerOnTask;

/// @brief 关闭任务
@property (strong, nonatomic) LightSignleTask *powerOffTask;

@end
