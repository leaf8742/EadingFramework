#import "EasyLink.h"
#import "AsyncUdpSocket.h"

@interface EasyLink()

/// @brief UDP组件
@property (retain, nonatomic) AsyncUdpSocket *socket;

/// @brief 组播包
@property (retain, nonatomic) NSMutableArray *array;

/// @brief Easylink配置间隔时间
@property (retain, nonatomic) NSTimer *timer;

/// @brief 生成指定长度的NSData
+ (NSData *)dataWithLength:(NSUInteger)length;

@end


@implementation EasyLink

/// @brief 单例
+ (EasyLink *)sharedInstance {
    static EasyLink *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [NSAllocateObject([self class], 0, NULL) init];
    });
    return sharedClient;
}

/// @brief 开始配置
- (void)startWithSSID:(NSString *)bSSID password:(NSString *)bpasswd info:(NSString *)userInfo {
    if (bSSID == nil) bSSID = @"";
    if (bpasswd == nil) bpasswd = @"";
    if (userInfo == nil) userInfo = @"";
    NSString *mergeString =  [bSSID stringByAppendingString:bpasswd];
    
    const char *bSSID_UTF8 = [bSSID UTF8String];
    const char *bpasswd_UTF8 = [bpasswd UTF8String];
    const char *userInfo_UTF8 = [userInfo UTF8String];
    const char *mergeString_UTF8 = [mergeString UTF8String];
    
    NSUInteger bSSID_length = strlen(bSSID_UTF8);
    NSUInteger bpasswd_length = strlen(bpasswd_UTF8);
    NSUInteger userInfo_length = strlen(userInfo_UTF8);
    NSUInteger mergeString_Length = strlen(mergeString_UTF8);
    
    NSUInteger headerLength = 20;
    self.array = [NSMutableArray array];
    
    // 239.118.0.0
    for (NSUInteger idx = 0; idx != 5; ++idx) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setValue:[EasyLink dataWithLength:headerLength] forKey:@"sendData"];
        [dictionary setValue:@"239.118.0.0" forKey:@"host"];
        [self.array addObject:dictionary];
    }
    
    // 239.126.ssidlen.passwdlen
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:[EasyLink dataWithLength:headerLength] forKey:@"sendData"];
    [dictionary setValue:[NSString stringWithFormat:@"239.126.%lu.%lu", (unsigned long)bSSID_length, (unsigned long)bpasswd_length] forKey:@"host"];
    [self.array addObject:dictionary];
    headerLength++;
    
    // 239.126.mergeString[idx],mergeString[idx+1]
    for (NSUInteger idx = 0; idx < mergeString_Length; idx += 2, headerLength++) {
        Byte a = mergeString_UTF8[idx];
        Byte b = 0;
        if (idx + 1 != mergeString_Length)
            b = mergeString_UTF8[idx+1];
        
        dictionary = [NSMutableDictionary dictionary];
        
        [dictionary setValue:[EasyLink dataWithLength:headerLength] forKey:@"sendData"];
        [dictionary setValue:[NSString stringWithFormat:@"239.126.%d.%d", a, b] forKey:@"host"];
        [self.array addObject:dictionary];
    }
    
    // 239.126.userinfolen.0
    dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:[EasyLink dataWithLength:headerLength] forKey:@"sendData"];
    [dictionary setValue:[NSString stringWithFormat:@"239.126.%lu.0", (unsigned long)userInfo_length] forKey:@"host"];
    [self.array addObject:dictionary];
    headerLength++;
    
    // 239.126.userinfo[idx],userinfo[idx+1]
    for (NSUInteger idx = 0; idx < userInfo_length; idx += 2, headerLength++) {
        Byte a = userInfo_UTF8[idx];
        Byte b = 0;
        if (idx + 1 != userInfo_length)
            b = userInfo_UTF8[idx+1];
        
        dictionary = [NSMutableDictionary dictionary];
        [dictionary setValue:[EasyLink dataWithLength:headerLength] forKey:@"sendData"];
        [dictionary setValue:[NSString stringWithFormat:@"239.126.%d.%d", a, b] forKey:@"host"];
        [self.array addObject:dictionary];
    }

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startConfigure:) userInfo:nil repeats:YES];
}

- (void)startConfigure:(id)sender {
    static NSUInteger count = 0;
    if (count == [self.array count]) count = 0;

    self.socket = [[[AsyncUdpSocket alloc] initWithDelegate:nil] autorelease];
    NSError *error;
    [self.socket enableBroadcast:YES error:&error];
    [self.socket sendData:[[self.array objectAtIndex:count] objectForKey:@"sendData"] toHost:[[self.array objectAtIndex:count] objectForKey:@"host"] port:8080 withTimeout:10 tag:0];

    ++count;
}

/// @brief 结束配置
- (void)stop {
    [self.timer invalidate];
}

+ (NSData *)dataWithLength:(NSUInteger)length {
    NSMutableData *data = [NSMutableData dataWithLength:length];
    return data;
}

- (void)dealloc {
    [_socket release];
    [_array release];
    [_timer release];
    [super dealloc];
}

@end
