/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>

/**
 * @enum kAccountType
 * @brief 登录帐户类型
 * @author 单宝华
 * @date 2014-12-2
 */
typedef NS_ENUM(NSInteger, kAuthority) {
    /// @brief 超级管理员
    kAuthoritySuper = 01,
    
    /// @brief 管理员
    kAuthorityAdministrator = 02,
    
    /// @brief 无权限用户
    kAuthorityCustomer = 03,
    
    /// @brief 测试模式
    kAuthorityGuest,
};

/**
 * @enum kAccountType
 * @brief 登录帐户类型
 * @author 单宝华
 * @date 2014-12-2
 */
typedef NS_ENUM(NSInteger, kAccountType) {
    /// @brief 测试模式
    kAccountTypeGuest,
    
    /// @brief 手机登录
    kAccountTypeMobile,
    
    /// @brief 邮箱登录
    kAccountTypeEmail,
    
    /// @brief QQ登录
    kAccountTypeTencent,
    
    /// @brief 微信登录
    kAccountTypeWeChat,
    
    /// @brief 微博登录
    kAccountTypeWeibo
};

/**
 * @enum kEAObjectType
 * @brief 对象类型
 * @author 单宝华
 * @date 2014-12-2
 */
typedef NS_ENUM(NSInteger, kEAObjectType) {
    /// @brief Non
    kEAObjectTypeUnknown = 0,
    
    /// @brief 魔盒
    kEAObjectTypeBox = 1 << 0,
    
    /// @brief Wi-Fi摄像头
    kEAObjectTypeCamera = 1 << 1,
    
    /// @brief Wi-Fi灯
    kEAObjectTypeLight = 1 << 2,
    
    /// @brief Wi-Fi插排
    kEAObjectTypeSocket = 1 << 3,
    
    /// @brief 插孔
    kEAObjectTypeJack = 1 << 4,
    
    /// @brief 红外遥控器
    kEAObjectTypeRemote = 1 << 5,
    
    /// @brief 情景模式
    kEAObjectTypeProfile = 1 << 6,
    
    /// @brief 微控魔盒
    kEAObjectTypeWecon = 1 << 7,
    
    /// @brief 空调主控板
    kEAObjectTypeBYAC = 1 << 8,
};

/**
 * @enum kSubType
 * @brief 魔盒子类型
 * @author 单宝华
 * @date 2015-02-12
 */
typedef NS_ENUM(NSInteger, kSubType) {
    /// @brief 未知设备
    kSubTypeUnknown,
    
    /// @brief 魔盒类
    kSubTypeBoxGeneral,
    
    /// @brief 互联网插座
    kSubTypeNetwork,
    
    /// @brief 小芒果
    kSubTypeMango,
};

/**
 * @enum kEABoxType
 * @brief 魔盒类型的子类型
 * @author 单宝华
 * @date 2014-12-18
 */
typedef NS_ENUM(NSInteger, kEABoxType) {
    /// @brief 魔盒AB款
    kEABoxTypeEABox,
    
    /// @brief 互联网插座
    kEABoxTypeInternet,
    
    /// @brief 京东版
    kEABoxTypeJD,
    
    /// @brief 小芒果
    kEABoxTypeMango,
};

/**
 * @enum kRemoteType
 * @brief 遥控器类型
 * @author 单宝华
 * @date 2014-12-2
 */
typedef NS_ENUM(NSInteger, kRemoteType) {
    /// @brief 电视
    kRemoteTypeTelevision = 1,
    
    /// @brief 机顶盒
    kRemoteTypeTVBox,
    
    /// @brief 空调
    kRemoteTypeAirConditioner,
    
    /// @brief 自定义
    kRemoteTypeCustom = 99,
};

/**
 * @enum kRemoteMapSource
 * @brief 码库来源
 * @author 单宝华
 * @date 2014-12-2
 */
typedef NS_ENUM(NSInteger, kRemoteMapSource) {
    /// @brief 官方码库
    kRemoteMapSourceOfficial = 1,
    
    /// @brief 用户码库
    kRemoteMapSourceOther = 2,
};

/**
 * @enum kProfileType
 * @brief 情景模式类型
 * @author 单宝华
 * @date 2014-12-2
 */
typedef NS_ENUM(NSInteger, kProfileType) {
    /// @brief 定时情景模式
    kProfileTypeTiming,
    
    /// @brief 触发情景模式
    kProfileTypeEvent,
};

/**
 * @enum kOperateCommand
 * @brief 操作命令
 * @author 单宝华
 * @date 2014-12-3
 */
typedef NS_ENUM(NSInteger, kOperateCommand) {
    /// @brief 开启命令
    kOperateCommandOn,
    
    /// @brief 关闭命令
    kOperateCommandOff,
    
    /// @brief 开关切换
    kOperateCommandPowerSwitch,
    
    /// @brief 锁定
    kOperateCommandLock,
    
    /// @brief 解锁
    kOperateCommandUnlock,
    
    /// @brief 锁定切换
    kOperateCommandLockSwitch,
    
    /// @brief 刷新
    kOperateCommandRefresh,
    
    /// @brief 学习
    kOperateCommandStudy,
    
    /// @brief 调整颜色
    kOperateCommandColor,
};

/**
 * @enum kTaskType
 * @brief 任务类型
 * @author 单宝华
 * @date 2014-12-3
 */
typedef NS_ENUM(NSInteger, kTaskType) {
    /// @brief 魔盒任务
    kTaskTypeBox,
    
    /// @brief 空调主控板任务
    kTaskTypeBYAC,
    
    /// @brief 定时情景模式任务
    kTaskTypeTimingProfile,
    
    /// @brief 触发情景模式任务
    kTaskTypeEventProfile
};

/**
 * @enum kWeekDay
 * @brief 星期
 * @author 单宝华
 * @date 2014-12-3
 */
typedef NS_ENUM(NSInteger, kWeekDay) {
    /// @brief 星期日
    kSunday     = 1 << 0,
    
    /// @brief 星期一
    kMonday     = 1 << 1,
    
    /// @brief 星期二
    kTuesday    = 1 << 2,
    
    /// @brief 星期三
    kWednesday  = 1 << 3,
    
    /// @brief 星期四
    kThursday   = 1 << 4,
    
    /// @brief 星期五
    kFriday     = 1 << 5,
    
    /// @brief 星期六
    kSaturday   = 1 << 6
};

/**
 * @enum KAlarmTimeSegType
 * @brief 定时时间段，24小时制
 */
typedef NS_ENUM(NSInteger, kAlarmTimeSegType) {
    /// @brief 1-5点
    kDeepNight = 0,
    /// @brief 5-9 点
    kMorning,
    /// @brief 9-13 点
    kMiddle,
    /// @brief 13-17 点
    kAfternoon,
    /// @brief 17-21 点
    kNight,
    /// @brief 21-1点
    kMiddleNight,
    /// @brief 不可用等状态
    kDefault
};

/**
 * @enum kAttachmentType
 * @brief 配件类型
 * @author 单宝华
 * @date 2014-12-3
 */
typedef NS_ENUM(NSInteger, kAttachmentType) {
    /// @brief 无配件
    kAttachmentTypeNone,
    
    /// @brief 人体
    kAttachmentTypeBody,
    
    /// @brief 一氧化碳
    kAttachmentTypeCarbonMonoxide,
    
    /// @brief 甲醛
    kAttachmentTypeFormaldehyde,
    
    /// @brief 甲烷
    kAttachmentTypeMethane,
    
    /// @brief 烟雾
    kAttachmentTypeSmog,
    
    /// @brief 温湿度
    kAttachmentTypeTemperatureHumidity,
    
    /// @brief 万向红外
    kAttachmentTypeRemote,
    
    /// @brief 未知配件
    kAttachmentTypeUnknown,
};

typedef NS_ENUM(NSInteger, kElectricType) {
    /// @brief 自定义
    kElectricTypeCustom = 00,
    /// @brief 电视
    kElectricTypeTV = 01,
    /// @brief 空调
    kElectricTypeAIR,
    /// @brief 灯
    kElectricTypeLamp,
    /// @brief 电磁炉
    kElectricTypeMicrowave,
    /// @brief 电饭锅
    kElectricTypeCooker,
    /// @brief 电风扇
    kElectricTypeFan,
    /// @brief 电热水壶
    kElectricTypeEkettle,
    /// @brief 电热毯
    kElectricTypeBlanket,
    /// @brief 机顶盒
    kElectricTypeStb,
    /// @brief 加湿器
    kElectricTypeTreater,
    /// @brief 空气净化器
    kElectricTypeAirCleaner,
    /// @brief 平板灯
    kElectricTypeLed,
    /// @brief 热水器
    kElectricTypeHeater,
    /// @brief 射灯
    kElectricTypeSpotlight,
    /// @brief 筒灯
    kElectricTypeTubeLight,
    /// @brief 吸顶灯
    kElectricTypeCeilingLight,
    /// @brief 洗衣机
    kElectricTypeWasher,
    /// @brief 饮水机
    kElectricTypeWdispensert,
};

/**
 * @enum kCellScheme
 * @brief Cell所在Table中的位置
 * @author 单宝华
 * @date 2015-03-02
 */
typedef NS_ENUM(NSInteger, kCellScheme) {
    kCellSchemeUp = 0,
    kCellSchemeCenter,
    kCellSchemeBottom,
    kCellSchemeSingle
};

/**
 * @enum kAirConditionerFanSpeed
 * @brief 空调风速
 * @author 单宝华
 * @date 2015-04-02
 */
typedef NS_ENUM(NSInteger, kAirConditionerFanSpeed) {
    /// @brief 自动
    kAirConditionerFanSpeedAuto,
    
    /// @brief 低速
    kAirConditionerFanSpeedLow,
    
    /// @brief 中速
    kAirConditionerFanSpeedMed,
    
    /// @brief 高速
    kAirConditionerFanSpeedHigh,
    
    /// QUIET
};

/**
 * @enum kAirConditionerMode
 * @brief 空调模式
 * @author 单宝华
 * @date 2015-04-02
 */
typedef NS_ENUM(NSInteger, kAirConditionerMode) {
    /// @brief 未知类型
    kAirConditionerModeUnknown,
    
    /// @brief 自动
    kAirConditionerModeAuto,
    
    /// @brief 制冷
    kAirConditionerModeCool,
    
    /// @brief 除湿
    kAirConditionerModeDry,
    
    /// @brief 通风
    kAirConditionerModeFan,
    
    /// @brief 制热
    kAirConditionerModeHeat,
    
};
