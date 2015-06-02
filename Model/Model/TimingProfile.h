/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "ProfileGeneral.h"

/**
 * @class TimingProfile
 * @brief 定时情景模式
 * @author 单宝华
 * @date 2014-12-3
 */
@interface TimingProfile : NSObject<ProfileGeneral>

/// @brief 定时时间
@property (strong, nonatomic) NSDate *enabledTime;

@end
