/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "Common.h"

@class AttachmentList;
@protocol AttachmentGeneral;

/**
 * @protocol DeviceGeneral
 * @brief 物理硬件协议
 * @author 单宝华
 * @date 2014-12-2
 */
@protocol DeviceGeneral <NSObject>

/// @brief 恢复出厂
@property (assign, nonatomic) BOOL restoreFactory;

/// @breif 在线
@property (assign, nonatomic) BOOL online;

/// @brief 锁定
@property (assign, nonatomic) BOOL locked;

/// @brief 非法设备
@property (assign, nonatomic) BOOL invalide;

/// @brief 附件列表
@property (strong, nonatomic) AttachmentList *attachmentList;

#warning users中的权限，要与DeviceGeneral中的权限统一
/// @brief 权限
@property (assign, nonatomic) kAuthority authority;

/// @brief 当前设备的用户列表
@property (strong, nonatomic) NSMutableSet *users;

/// @brief 固件版本
@property (strong, nonatomic) NSString *firmwareVer;

/// @brief 固件是否需要升级
@property (assign, nonatomic) BOOL isNeedUpdate;

/// @brief 出厂地址
@property (strong, nonatomic) NSString *factoryAddr;

/// @brief AttachmentList中的被选择配件 selectedAttachment
@property (strong, nonatomic) id<AttachmentGeneral> attachment;

@end

/**
 @synthesize restoreFactory = _restoreFactory;
 @synthesize online = _online;
 @synthesize locked = _locked;
 @synthesize invalide = _invalide;
 @synthesize attachmentList = _attachmentList;
 @synthesize authority = _authority;
 @synthesize users = _users;
 @synthesize firmwareVer = _firmwareVer;
 @synthesize isNeedUpdate = _isNeedUpdate;
 @synthesize factoryAddr = _factoryAddr;
 @synthesize attachment = _attachment;
*/