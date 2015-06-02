#import "SmartLink.h"
#import "GCDAsyncUdpSocket.h"
#import "APManager.h"

#define UDPLOCALPORT  49999
#define BASELEN      76
#define STARTCODE    '\r'
#define STOPCODE     '\n'


@interface SmartLink()


@property (retain, nonatomic) GCDAsyncUdpSocket *socket;

/// @brief 子网掩码
@property (retain, nonatomic) NSString *broadcast;

/// @brief 组播包
@property (retain, nonatomic) NSMutableArray *array;

/// @brief 密码
@property (retain, nonatomic) NSString *passwd;

/// @brief 当前发送的位置
@property (assign, nonatomic) NSUInteger currentIdx;

/// @brief 是否停止
@property (assign, nonatomic) BOOL started;

@end


@implementation SmartLink

/// @brief 单例
+ (SmartLink *)sharedInstance {
    static SmartLink *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [NSAllocateObject([self class], 0, NULL) init];
    });
    return sharedClient;
}

- (void)buildHead {
    for (NSUInteger idx = 0; idx != 200; ++idx) {
        NSData *data = [NSMutableData dataWithLength:BASELEN];
        NSTimeInterval interval = 10;
        [self.array addObject:[NSDictionary dictionaryWithObjectsAndKeys:data, @"data", [NSNumber numberWithDouble:interval], @"interval", nil]];
    }
}

- (void)buildStart {
    for (NSUInteger idx = 0; idx != 3; ++idx) {
        NSData *data = [NSMutableData dataWithLength:BASELEN + STARTCODE];
        NSTimeInterval interval = 50;
        [self.array addObject:[NSDictionary dictionaryWithObjectsAndKeys:data, @"data", [NSNumber numberWithDouble:interval], @"interval", nil]];
    }
}

- (void)buildEnd {
    for (NSUInteger idx = 0; idx != 3; ++idx) {
        NSData *data = [NSMutableData dataWithLength:BASELEN + STOPCODE];
        NSTimeInterval interval = 50;
        [self.array addObject:[NSDictionary dictionaryWithObjectsAndKeys:data, @"data", [NSNumber numberWithDouble:interval], @"interval", nil]];
    }
}

- (void)buildVerify {
    for (NSUInteger idx = 0; idx != 3; ++idx) {
        NSData *data = [NSMutableData dataWithLength:BASELEN + 256 + [self.passwd length]];
        NSTimeInterval interval = 50;
        [self.array addObject:[NSDictionary dictionaryWithObjectsAndKeys:data, @"data", [NSNumber numberWithDouble:interval], @"interval", nil]];
    }
}

- (void)buildData {
    [self.passwd enumerateSubstringsInRange:NSMakeRange(0, [self.passwd length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        NSData *data = [NSMutableData dataWithLength:BASELEN + [substring characterAtIndex:0]];
        NSTimeInterval interval = 50;
        [self.array addObject:[NSDictionary dictionaryWithObjectsAndKeys:data, @"data", [NSNumber numberWithDouble:interval], @"interval", nil]];
    }];
}

- (void)startWithPasswd:(NSString *)passwd {
    [self.socket close];
    
    self.broadcast = [[APManager sharedInstance] getBroadcast];
    self.socket = [[[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()] autorelease];
    
    self.passwd = passwd;
    self.array = [NSMutableArray array];
    [self buildHead];
    for (NSUInteger idx = 0; idx != 5; ++idx) {
        [self buildStart];
        [self buildData];
        [self buildEnd];
        [self buildVerify];
    }
    self.currentIdx = 0;
    self.started = YES;
    [self sendData];
}

- (void)stop {
    self.started = NO;
    [self.socket close];
}

- (void)sendData {
    int port = UDPLOCALPORT;
    self.currentIdx = (self.currentIdx + 1) % [self.array count];
    NSDictionary *msg = [self.array objectAtIndex:self.currentIdx];
    NSData *data = [msg objectForKey:@"data"];
    NSTimeInterval interval = [[msg objectForKey:@"interval"] doubleValue];
    [self.socket bindToPort:port error:nil];
    [self.socket beginReceiving:nil];
    [self.socket enableBroadcast:YES error:nil];
    [self.socket sendData:data toHost:self.broadcast port:port withTimeout:-1 tag:1];
    
    if (self.started) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [self sendData];
        });
    }
}

- (void)dealloc {
    [_broadcast release];
    [_array release];
    [_passwd release];
    [super dealloc];
}

@end
