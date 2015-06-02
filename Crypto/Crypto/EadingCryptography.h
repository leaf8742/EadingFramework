/**
 * @file
 * @author 单宝华
 * @date 2013/09/24
 * @copyright 大连一丁芯智能技术有限公司
 */
#import <Foundation/Foundation.h>

/**
 * @class EadingCryptography
 * @brief 加解密统一处理
 * @author 单宝华
 * @date 2013/09/24
 */
@interface EadingCryptography : NSObject

/// @brief 加密字符串
+ (NSString *)encryptionWithString:(NSString *)string;

/// @brief 解密字符串
+ (NSString *)decryptionWithString:(NSString *)string;

/// @brief 解析xml字符串
+ (NSString *)stringByDecodingXMLEntities:(NSString *)string;

@end
