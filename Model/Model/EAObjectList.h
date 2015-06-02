/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "Common.h"

@class ApplianceInformation;
@protocol EAObjectGeneral;

/**
 * @class EAObjectList
 * @brief 对象列表
 * @author 单宝华
 * @date 2014-12-2
 */
@interface EAObjectList : NSObject

/// @brief 对象
@property (strong, nonatomic) NSMutableSet *objects;

/// @brief 已选择的对象
@property (weak, nonatomic) id<EAObjectGeneral> selectedObject;

/// @brief 电器列表
@property (strong, nonatomic) NSMutableSet *appliances;

/// @brief 已选择的电器
@property (strong, nonatomic) ApplianceInformation *selectedAppliance;

/// @brief 操作信息
@property (retain, nonatomic) NSMutableArray *ChangeRecordArray;

/// @brief 根据唯一标识查找对象
/// @return 如果对象列表中没有，返回nil
+ (id<EAObjectGeneral>)objectWithIdentity:(NSString *)identity;

/// @brief 根据唯一标识和类型查找对象
/// @return 如果对象列表中没有，返回一个新建的
+ (id<EAObjectGeneral>)objectWithIdentity:(NSString *)identity type:(kEAObjectType)type;

/// @brief 根据附件标识查找插座，哪个插座上边插了这个万向，反回哪个插座
/// @return 如果对象列表中没有，返回nil
+ (id<EAObjectGeneral>)objectWithAttachmentIdentity:(NSString *)identity;

/// @brief 智能设备列表
- (NSArray *)intelligenceDevices;

- (NSSet *)filteredObjectsWithObjectType:(kEAObjectType)type;

- (ApplianceInformation *)applianceWithID:(NSString *)applianceID;

@end
