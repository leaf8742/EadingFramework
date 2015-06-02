/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "Common.h"

/**
 * @protocol TaskGeneral
 * @brief 任务协议
 * @author 单宝华
 * @date 2014-12-3
 */
@protocol TaskGeneral <NSObject>

/// @brief 身份唯一标识
@property (strong, nonatomic) NSString *identity;

///// @brief 开启时间
//@property (strong, nonatomic) NSDate *onDate;
//
///// @brief 关闭时间
//@property (strong, nonatomic) NSDate *offDate;
//
///// @brief 开启有效性
//@property (nonatomic) BOOL onEnable;
//
///// @brief 关闭有效性
//@property (nonatomic) BOOL offEnable;

/// @brief 任务有效性
@property (nonatomic) BOOL taskEnable;

/// @brief 星期
@property (assign, nonatomic) kWeekDay week;

/// @brief 任务类型，包括alarm与delay
@property (strong, nonatomic) NSString *taskType;

/// @brief 定时任务时间段
@property (assign, nonatomic) kAlarmTimeSegType alarmTimeType;

@end
