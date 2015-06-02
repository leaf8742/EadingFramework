/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "Common.h"
@protocol TaskGeneral;

/**
 * @class TaskList
 * @brief 任务列表
 * @author 单宝华
 * @date 2014-12-3
 */
@interface TaskList : NSObject

/// @brief 任务类型
@property (assign, nonatomic) kTaskType type;

/// @brief 任务列表
@property (strong, nonatomic) NSMutableSet *tasks;

/// @brief 当前被选择的任务
@property (strong, nonatomic) id<TaskGeneral> selectedTask;

- (id<TaskGeneral>)taskWithIdentity:(NSString *)identity;

@end
