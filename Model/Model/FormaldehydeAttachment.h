/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "AttachmentGeneral.h"

/**
 * @class FormaldehydeAttachment
 * @brief 甲醛配件
 * @author 单宝华
 * @date 2014-12-3
 */
@interface FormaldehydeAttachment : NSObject<AttachmentGeneral>

/// @brief 甲醛附件时记录
@property (strong, nonatomic) NSArray *formaldehydeRecordsHourly;

/// @brief 甲醛附件浓度值
@property (nonatomic) float formaldehyde;

@end
