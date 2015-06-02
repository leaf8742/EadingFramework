/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "Common.h"

@protocol EAObjectGeneral;

/**
 * @class ProfileTask
 * @brief 情景模式任务
 * @author 单宝华
 * @date 2014-12-3
 */
@interface ProfileTask : NSObject

/// @brief 执行的对象
@property (strong, nonatomic) id<EAObjectGeneral> object;

/// @brief 执行的任务
@property (assign, nonatomic) kOperateCommand command;

@end
