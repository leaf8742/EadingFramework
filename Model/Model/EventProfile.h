/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "ProfileGeneral.h"

@protocol AttachmentGeneral;

/**
 * @class EventProfile
 * @brief 触发情景模式
 * @author 单宝华
 * @date 2014-12-3
 */
@interface EventProfile : NSObject<ProfileGeneral>

/// @brief 触发的配件
@property (strong, nonatomic) id<AttachmentGeneral> eventAttachment;

/// @brief 开始时间
@property (strong, nonatomic) NSDate *beginTime;

/// @brief 结束时间
@property (strong, nonatomic) NSDate *endTime;

@end
