#import "SmartConnection.h"
#import "smtiot.h"

@implementation SmartConnection

+ (SmartConnection *)sharedInstance {
    static SmartConnection *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [NSAllocateObject([self class], 0, NULL) init];
    });
    return sharedClient;
}

/// @brief 开始配置
- (void)startWithSSID:(NSString *)SSID password:(NSString *)passwd {
    const char *s_authmode = [@"" UTF8String];
    int authmode = atoi(s_authmode);
    InitSmartConnection();
    StartSmartConnection([SSID UTF8String], [passwd UTF8String], "", authmode);
}

/// @brief 结束配置
- (void)stop {
    StopSmartConnection();
}

@end
