/**
 * @file
 * @author 单宝华
 * @date 2014-12-9
 */
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 * @enum kPrimitiveKind
 * @brief 图形类型
 * @author 单宝华
 * @date 2014-12-9
 */
typedef NS_ENUM(NSInteger, kPrimitiveKind) {
    /// @brief 直线
    kPrimitiveKindLineSegment = 0,
    
    /// @brief 矩形
    kPrimitiveKindRectangle,
    
    /// @brief 圆形
    kPrimitiveKindCircle,
    
    /// @brief 椭圆
    kPrimitiveKindEllips,
    
    /// @brief 弧形
    kPrimitiveKindArc,
    
    /// @brief 多边形
    kPrimitiveKindPolygon
};

/**
 * @class PrimitiveLayer
 * @brief 基础图元
 * @author 单宝华
 * @date 2014-12-9
 */
@interface PrimitiveLayer : CAShapeLayer

/**
 * @brief 在画板上画图
 * @param appearance 外观描述
 * @param board 画板
 */
+ (void)appearance:(NSString *)appearance drawWithBoard:(CALayer *)board;

/// @brief 创建基础图元
+ (PrimitiveLayer *)primitiveFromDictionaryRepresent:(NSDictionary *)dictionary;

/// @brief 读取字典中的信息
- (void)makeWithDictionaryRepresentation:(NSDictionary *)dictionary;

@end
