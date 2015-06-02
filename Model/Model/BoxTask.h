/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "TaskGeneral.h"
@class SingleBoxTask;

/**
 * @class BoxTask
 * @brief 魔盒任务
 * @author 单宝华
 * @date 2014-12-3
 */
@interface BoxTask : NSObject<TaskGeneral>

/// @brief 开启任务
@property (strong, nonatomic) SingleBoxTask *powerOnTask;

/// @brief 关闭任务
@property (strong, nonatomic) SingleBoxTask *powerOffTask;

@end
