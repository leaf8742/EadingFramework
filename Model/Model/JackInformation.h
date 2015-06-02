/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
@class TaskList;

/**
 * @class JackInformation
 * @brief 插孔信息
 * @author 单宝华
 * @date 2014-12-3
 */
@interface JackInformation : NSObject<EAObjectGeneral>

/// @brief 任务列表
@property (strong, nonatomic) TaskList *taskList;

/// @brief 开关
@property (assign, nonatomic) BOOL powerOn;

@end
