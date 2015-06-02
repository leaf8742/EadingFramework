/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "EAObjectGeneral.h"
#import "DeviceGeneral.h"
#import "WirelessGeneral.h"
#import "RemoteAttachment.h"
#import "Common.h"

/**
 * @enum kRemoteStatus
 * @brief 遥控器状态
 * @author 单宝华
 * @date 2014/06/19
 */
typedef enum {
    /// @brief 无状态
    kRemoteStatusNone,
    /// @brief 新遥控器
    kRemoteStatusNew,
    /// @brief 删除遥控器
    kRemoteStatusRemove,
    /// @brief 修改过的遥控器
    kRemoteStatusModify,
} kRemoteStatus;

/**
 * @class RemoteInformation
 * @brief  遥控器信息
 * @author 单宝华
 * @date 2014-12-2
 */
@interface RemoteInformation : NSObject<EAObjectGeneral>

/// @brief 遥控器类型
@property (assign, nonatomic) kRemoteType type;

/// @brief 当前状态
@property (assign, nonatomic) kRemoteStatus status;

/// @brief 码库来源
@property (assign, nonatomic) kRemoteMapSource source;

/// @brief 发送与接收红外的载体
@property (strong, nonatomic) RemoteAttachment *carrier;

/// @brief 品牌
@property (strong, nonatomic) NSString *brand;

/// @brief 型号
@property (strong, nonatomic) NSString *model;

/// @brief  码表字典[{"key":"power", "value":56, "sort":10, img, title}, {"key":"mute", "value":65, "sort":11}]
@property (strong, nonatomic) NSMutableArray *keymap;

/// @brief 是否在等待学习
@property (assign, nonatomic) BOOL ready;

/// @brief 根据key取键值字典
- (NSMutableDictionary *)dictionaryWithKey:(NSString *)key;

@end
