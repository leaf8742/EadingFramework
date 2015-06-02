/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
#import "Common.h"

@class ProfileTask;

/**
 * @protocol ProfileGeneral
 * @brief 情景模式协议
 * @author 单宝华
 * @date 2014-12-2
 */
@protocol ProfileGeneral <EAObjectGeneral>

/// @brief 情景模式任务
@property (strong, nonatomic) NSMutableArray *commandTasks;

/// @brief 临时的任务，要在两个界面传递，ProfileTask
@property (strong, nonatomic) NSMutableArray *tempCommandTasks;

/// @brief 情景模式类型
@property (assign, nonatomic) kProfileType type;

/// @brief 是否启用
@property (assign, nonatomic) BOOL enabled;

@end

/**
 @synthesize commandTasks = _commandTasks;
 @synthesize tempCommandTasks = _tempCommandTasks;
 @synthesize type = _type;
 @synthesize enabled = _enabled;
 */
