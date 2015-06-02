/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "Common.h"
@protocol AttachmentGeneral;

/**
 * @class AttachmentList
 * @brief 配件列表
 * @author 单宝华
 * @date 2014-12-3
 */
@interface AttachmentList : NSObject

/// @brief 配件列表
@property (strong, nonatomic) NSMutableSet *attachments;

/// @brief 被选择的配件
@property (strong, nonatomic) id<AttachmentGeneral> selectedAttachment;

/// @brief 根据唯一标识查找配件
/// @return 如果配件列表中没有，返回nil
+ (id<AttachmentGeneral>)attachmentWithIdentity:(NSString *)identity;

/// @brief 根据唯一标识和类型查找对象
/// @return 如果对象列表中没有，返回一个新建的
+ (id<AttachmentGeneral>)attachmentWithIdentity:(NSString *)identity type:(kAttachmentType)type;

@end
