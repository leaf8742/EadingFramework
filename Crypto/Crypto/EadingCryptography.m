#import "EadingCryptography.h"
#import "NSData+CommonCrypto.h"

@implementation EadingCryptography

const NSString * const kKeyExpansion = @"1234567890123456";
const NSString * const kVector = @"1234567890123456";

+ (NSString *)encryptionWithString:(NSString *)string {
    NSData *toencrypt = [string dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus status = kCCSuccess;
    NSData *encrypted = [toencrypt dataEncryptedUsingAlgorithm:kCCAlgorithmAES128 key:kKeyExpansion initializationVector:kVector options:kCCOptionPKCS7Padding error:&status];
    return [encrypted base64Encoding];
}

+ (NSString *)decryptionWithString:(NSString *)string {
    CCCryptorStatus status = kCCSuccess;
    NSData *AESData = [[NSData dataWithBase64EncodedString:string] decryptedDataUsingAlgorithm:kCCAlgorithmAES128 key:kKeyExpansion initializationVector:kVector options:kCCOptionPKCS7Padding error:&status];
    NSString *result = [[[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding] autorelease];
    result = [result stringByReplacingOccurrencesOfString:@"\"<null>\"" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];

    return result;
}

+ (NSString *)stringByDecodingXMLEntities:(NSString *)string {
    if (string == nil) return nil;
    NSString *result = [string stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"UTF-8\"?>" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    result = [result stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    result = [result stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    result = [result stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@">([\n\t ]+)<"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
    result = [regular stringByReplacingMatchesInString:result options:0 range:NSMakeRange(0, [result length]) withTemplate:@"><"];
    [regular release];
    
    return result;
}

@end
