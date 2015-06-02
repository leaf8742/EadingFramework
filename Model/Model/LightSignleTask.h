/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Common.h"

/**
 * @class LightSignleTask
 * @brief Wi-Fi灯单任务
 * @author 单宝华
 * @date 2014-12-3
 */
@interface LightSignleTask : NSObject

/// @brief 任务命令
@property (assign, nonatomic) kOperateCommand command;

/// @brief 任务时间
@property (strong, nonatomic) NSDate *time;

/// @brief 任务是否启用
@property (assign, nonatomic) BOOL enabled;

/// @brief 任务颜色
@property (strong, nonatomic) UIColor *color;

@end
