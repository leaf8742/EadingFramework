//
//  ApplianceInformation.h
//  com.eading.wireless
//
//  Created by Q on 15/1/14.
//
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "EAObjectGeneral.h"

@protocol EAObjectGeneral;
@protocol DeviceGeneral;
@protocol WirelessGeneral;
@class RemoteInformation;
@class RemoteAttachment;
@class ApplianceTask;
@class UserList;

@interface ApplianceInformation : NSObject<EAObjectGeneral>

/// @brief 电器名称
@property (strong, nonatomic) NSString *name;

/// @brief 绑定设备
@property (strong, nonatomic) id<EAObjectGeneral, DeviceGeneral, WirelessGeneral>device;

/// @brief 绑定遥控器
@property (strong, nonatomic) RemoteInformation *remote;

/// @brief 电器最新任务
@property (strong, nonatomic) ApplianceTask *recentlyTask;

/// @brief 合并的电器ID集合
@property (strong, nonatomic) NSMutableSet *combineIdentities;

/// @brief 电器权限
@property (nonatomic) kAuthority authority;

/// @brief 插孔编号
@property (nonatomic) NSInteger jackNumber;

/// @brief 用户列表
@property (strong, nonatomic) UserList *userList;

/// @brief 设备开启状态
@property (nonatomic) BOOL devicePowerOn;

- (void)analyzeDeviceStateWithCode:(NSString *)code;

@end
