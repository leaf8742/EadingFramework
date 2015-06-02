/**
 * @file
 * @author 单宝华
 * @date 2014-12-16
 */
#import <Foundation/Foundation.h>
#import "Model.h"

/**
 * @function attachmentTypeWithString
 * @brief 根据服务器返回字符串确定附件类型
 */
extern kAttachmentType attachmentTypeWithString(NSString *string);

/**
 * @function deviceIsReady
 * @brief 设备是否在当前局域网内
 */
extern BOOL deviceIsReady(id<WirelessGeneral> device);

/**
 * @function
 * @brief 是否有外网权限
 */
extern BOOL deviceHasAuthority(id<DeviceGeneral> device);

/**
 * @function
 * @brief 未授权的权限
 */
extern kAuthority unauthorized();

/**
 * @function
 * @brief 产品对照，type, subType
 */
extern NSDictionary *productType(NSString *string);

/**
 * @function
 * @brief 设置类型，同上
 */
extern void objectSetType(id<EAObjectGeneral> object, NSString *string);

/**
 * @function
 * @brief 获取对象图片
 */
extern UIImage *objectImage(id object);

/**
 * @function
 * @brief 数字转换成16进制字符串
 */
extern NSInteger hexToDecimal(NSString *hexString);

/**
 * @function
 * @brief 16进制字符串转换成数字
 */
extern NSString *decimalToHex(NSInteger decimal);

/**
 * @function
 * @brief 构造任务重复信息
 */
extern void buildRepeat(NSString *repeat, id<TaskGeneral> task);
