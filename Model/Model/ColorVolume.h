/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


/// @brief 白色
FOUNDATION_EXPORT NSString *const ColorNameWhite;

/// @brief 黄色
FOUNDATION_EXPORT NSString *const ColorNameYellow;

/// @brief 红色
FOUNDATION_EXPORT NSString *const ColorNameRed;

/// @brief 蓝色
FOUNDATION_EXPORT NSString *const ColorNameBlue;

/// @brief 绿色
FOUNDATION_EXPORT NSString *const ColorNameGreen;

/**
 * @class ColorVolume
 * @brief 单色信息
 * @author 单宝华
 * @date 2014-12-3
 */
@interface ColorVolume : NSObject

/// @brief 单色名称
@property (strong, nonatomic) NSString *name;

/// @brief 色值
@property (assign, nonatomic) CGFloat volume;

@end
