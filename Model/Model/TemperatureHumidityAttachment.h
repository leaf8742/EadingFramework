/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "AttachmentGeneral.h"

/**
 * @class TemperatureHumidityAttachment
 * @brief 温湿度配件
 * @author 单宝华
 * @date 2014-12-3
 */
@interface TemperatureHumidityAttachment : NSObject<AttachmentGeneral>

/// @brief 温湿度附件温度值
@property (assign, nonatomic) float temperature;

/// @brief 温湿度附件湿度值
@property (assign, nonatomic) NSInteger humidity;

/// @brief 温湿度附件时记录
@property (retain, nonatomic) NSArray *temperatureRecordsHourly;

/// @brief 温湿度附件日记录
@property (retain, nonatomic) NSArray *temperatureRecordsDaily;

@end
