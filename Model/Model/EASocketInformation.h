/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
#import "WirelessGeneral.h"
#import "DeviceGeneral.h"

@class JackInformation;
@protocol AttachmentGeneral;

/**
 * @class EASocketInformation
 * @brief  Wi-Fi插排信息
 * @author 单宝华
 * @date 2014-12-2
 */
@interface EASocketInformation : NSObject<EAObjectGeneral, WirelessGeneral, DeviceGeneral>

/// @brief 内部配件
@property (strong, nonatomic) id<AttachmentGeneral> internalAttachment;

/// @brief 外部配件
@property (strong, nonatomic) id<AttachmentGeneral> externalAttachment;

/// @brief 插孔
@property (strong, nonatomic) NSMutableArray *jacks;

/// @brief 被选择的插孔
@property (strong, nonatomic) JackInformation *selectedJack;

- (void)setJackPowerStatWithCode:(NSString *)code;
- (BOOL)getJackPowerStatWithIndex:(NSInteger)index;

@end
