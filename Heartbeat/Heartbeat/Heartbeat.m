#import "Heartbeat.h"
#import <SearchDeviceManager/SearchDeviceManager.h>

@interface Heartbeat()

@property (strong, nonatomic) NSTimer *timer;

@end


@implementation Heartbeat

- (id)init {
    self = [super init];
    if (self) {
        self.heartbeatTimeInterval = 5;
    }
    return self;
}

+ (Heartbeat *)sharedInstance {
    static Heartbeat *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[Heartbeat alloc] init];
    });
    return sharedClient;
}

- (void)startHeartbeat {
    [self.timer invalidate];
    
    self.timer = [NSTimer timerWithTimeInterval:self.heartbeatTimeInterval target:self selector:@selector(heartbeat) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)suspend {
    [self.timer invalidate];
}

- (void)resume {
    [self.timer invalidate];
    
    self.timer = [NSTimer timerWithTimeInterval:self.heartbeatTimeInterval target:self selector:@selector(heartbeat) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)heartbeat {
    [SearchDeviceManager sendEABOX];
    [SearchDeviceManager sendEALight];
    [SearchDeviceManager sendEASOCKET];
    [SearchDeviceManager sendMango];
    [SearchDeviceManager sendBYAC];
}

@end
