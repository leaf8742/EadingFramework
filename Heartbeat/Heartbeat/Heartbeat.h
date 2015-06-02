/**
 * @file
 * @author 单宝华
 * @date 2014/03/06
 * @copyright 大连一丁芯智能技术有限公司
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * @class Heartbeat
 * @brief 插座与附件模型，以心跳形式更新
 * @author 单宝华
 * @date 2014/03/06
 */
@interface Heartbeat : NSObject

/// @brief 心跳频率
@property (assign, nonatomic) NSTimeInterval heartbeatTimeInterval;

/// @brief 单例
+ (Heartbeat *)sharedInstance;

/// @brief 开始心跳更新
- (void)startHeartbeat;

/// @brief 暂停心跳
- (void)suspend;

/// @brief 开始心跳
- (void)resume;

@end
