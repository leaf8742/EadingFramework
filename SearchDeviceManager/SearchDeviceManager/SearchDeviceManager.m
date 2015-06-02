#import "SearchDeviceManager.h"
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>
#import <APManager/APManager.h>
#import <Model/Model.h>
//#import "HardwareStore.h"

NSString *const FoundDevice = @"FoundDevice";

const NSUInteger sendPort = 8090;

@interface SearchDeviceManager()

/// @brief 单例
+ (instancetype)sharedInstance;

/// @brief 发现设备通知
@property (assign, nonatomic) BOOL disableNotifier;

/// @brief 魔盒
@property (strong, nonatomic) GCDAsyncUdpSocket *eaboxSocket;

/// @brief Wi-Fi灯
@property (strong, nonatomic) GCDAsyncUdpSocket *ealightSocket;

/// @brief 插排
@property (strong, nonatomic) GCDAsyncUdpSocket *easocketSocket;

/// @brief 小芒果
@property (strong, nonatomic) GCDAsyncUdpSocket *mangoSocket;

/// @brief 空调主控板
@property (strong, nonatomic) GCDAsyncUdpSocket *byacSocket;

@end


@implementation SearchDeviceManager

static dispatch_queue_t udp_processing_queue() {
    static dispatch_queue_t udp_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        udp_processing_queue = dispatch_queue_create("com.eading.wireless-udp.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return udp_processing_queue;
}

- (id)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleDidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];

        NSError *error;

        self.eaboxSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:udp_processing_queue()];
        while ([self.eaboxSocket bindToPort:random() error:&error]) {}
        
        self.ealightSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:udp_processing_queue()];
        while ([self.ealightSocket bindToPort:random() error:&error]) {}
        
        self.easocketSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:udp_processing_queue()];
        while ([self.easocketSocket bindToPort:random() error:&error]) {}
        
        self.mangoSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:udp_processing_queue()];
        while ([self.mangoSocket bindToPort:random() error:&error]) {}
        
        self.byacSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:udp_processing_queue()];
        while ([self.byacSocket bindToPort:random() error:&error]) {}
    }
    return self;
}

+ (instancetype)sharedInstance {
    static SearchDeviceManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SearchDeviceManager alloc] init];
    });
    
    return _sharedInstance;
}

+ (void)sendEABOX {
    NSString *broadcast = [[APManager sharedInstance] getBroadcast];
    NSError *error;
    
    [[[SearchDeviceManager sharedInstance] eaboxSocket] beginReceiving:&error];
    [[[SearchDeviceManager sharedInstance] eaboxSocket] enableBroadcast:YES error:&error];
    [[[SearchDeviceManager sharedInstance] eaboxSocket] sendData:[@"EABOX" dataUsingEncoding:NSUTF8StringEncoding] toHost:broadcast port:sendPort withTimeout:-1 tag:1];
}

+ (void)sendEALight {
    NSString *broadcast = [[APManager sharedInstance] getBroadcast];
    NSError *error;
    
    [[[SearchDeviceManager sharedInstance] ealightSocket] beginReceiving:&error];
    [[[SearchDeviceManager sharedInstance] ealightSocket] enableBroadcast:YES error:&error];
    [[[SearchDeviceManager sharedInstance] ealightSocket] sendData:[@"EALight" dataUsingEncoding:NSUTF8StringEncoding] toHost:broadcast port:sendPort withTimeout:-1 tag:1];
}

+ (void)sendEASOCKET {
    NSString *broadcast = [[APManager sharedInstance] getBroadcast];
    NSError *error;
    
    [[[SearchDeviceManager sharedInstance] easocketSocket] beginReceiving:&error];
    [[[SearchDeviceManager sharedInstance] easocketSocket] enableBroadcast:YES error:&error];
    [[[SearchDeviceManager sharedInstance] easocketSocket] sendData:[@"EASOCKET" dataUsingEncoding:NSUTF8StringEncoding] toHost:broadcast port:sendPort withTimeout:-1 tag:1];
}

+ (void)sendMango {
    NSString *broadcast = [[APManager sharedInstance] getBroadcast];
    NSError *error;
    
    [[[SearchDeviceManager sharedInstance] mangoSocket] beginReceiving:&error];
    [[[SearchDeviceManager sharedInstance] mangoSocket] enableBroadcast:YES error:&error];
    [[[SearchDeviceManager sharedInstance] mangoSocket] sendData:[@"Mango" dataUsingEncoding:NSUTF8StringEncoding] toHost:broadcast port:sendPort withTimeout:-1 tag:1];
}

+ (void)sendBYAC {
    NSString *broadcast = [[APManager sharedInstance] getBroadcast];
    NSError *error;
    
    [[[SearchDeviceManager sharedInstance] byacSocket] beginReceiving:&error];
    [[[SearchDeviceManager sharedInstance] byacSocket] enableBroadcast:YES error:&error];
    [[[SearchDeviceManager sharedInstance] byacSocket] sendData:[@"BYAC" dataUsingEncoding:NSUTF8StringEncoding] toHost:broadcast port:sendPort withTimeout:-1 tag:1];
}

+ (void)startNotifier {
    [[SearchDeviceManager sharedInstance] setDisableNotifier:NO];
}

+ (void)stopNotifier {
    [[SearchDeviceManager sharedInstance] setDisableNotifier:YES];
}

#pragma mark - GCDAsyncUdpSocketDelegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self parseModel:responseString source:sock];
}

- (void)parseModel:(NSString *)string source:(GCDAsyncUdpSocket *)source {
    NSDictionary *responseDevice = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    if (responseDevice == nil)
        return;
    
    id<EAObjectGeneral, WirelessGeneral, DeviceGeneral> device = nil;
    if ([source localPort] == [self.eaboxSocket localPort] || [source localPort] == [self.mangoSocket localPort]) {
        device = (EABoxInformation *)[EAObjectList objectWithIdentity:responseDevice[@"mac"] type:kEAObjectTypeBox];
        [device setLocked: ([responseDevice[@"lk"] integerValue] == 1)];
        [(EABoxInformation *)device setPowerOn: ([responseDevice[@"o_c"] integerValue] == 1)];
    } else if ([source localPort] == [self.ealightSocket localPort]) {
        device = (EALightInformation *)[EAObjectList objectWithIdentity:responseDevice[@"mac"] type:kEAObjectTypeLight];
        [device setLocked:([responseDevice[@"optn"][@"lk"] integerValue] == 1)];
        [(EALightInformation *)device setPowerOn:([responseDevice[@"optn"][@"o_c"] integerValue] == 1)];
        [(EALightInformation *)device setColors:[NSMutableDictionary dictionaryWithDictionary:responseDevice[@"optn"][@"colr"]]];
    } else if ([source localPort] == [self.easocketSocket localPort]) {
        device = (EASocketInformation *)[EAObjectList objectWithIdentity:[responseDevice objectForKey:@"mac"] type:kEAObjectTypeSocket];
        [(EASocketInformation *)device setLocked:([responseDevice[@"lk"] integerValue] == 1)];
#warning TODO setJackStatusWithOCStatus
//        [(WiringBoardInformation *)foundDevice setJacksStatusWithOCStatus:[responseDevice objectForKey:@"o_c"]];
    } else if ([source localPort] == [self.byacSocket localPort]) {
        device = (BYACInformation *)[EAObjectList objectWithIdentity:responseDevice[@"mac"] type:kEAObjectTypeBYAC];
        [device setLocked: ([responseDevice[@"lk"] integerValue] == 1)];
        [(BYACInformation *)device updateMode:[responseDevice[@"mode"] integerValue]];
        [(BYACInformation *)device setTemperature:[responseDevice[@"settemp"] integerValue]];
        [(BYACInformation *)device setEnvironmentTemp:[responseDevice[@"realtemp"] integerValue]];
        [(BYACInformation *)device updateTask:responseDevice];
    }

    device.ip = responseDevice[@"ip"];
    device.ssid = [[APManager sharedInstance] ssidForConnectedNetwork];
    device.restoreFactory = [[responseDevice objectForKey:@"cmd"] isEqualToString:@"1"];
    device.online = YES;
    
//    HardwareStore *hardwareStore = [[HardwareStore alloc] init];
//    [hardwareStore setCommand:kOperateCommandRefresh];
//    [hardwareStore setDevice:device];
//    [hardwareStore setOperationQueue:[NSOperationQueue currentQueue]];
//    [hardwareStore requestWithFinished:^(NSDictionary *responseInfo) {
//    } failure:^{
//    }];
    
    if (device.floor == 0) device.floor = 1;
    if (!deviceHasAuthority(device)) device.authority = unauthorized();
    
    NSMutableSet *devices = [NSMutableSet set];
    [devices unionSet:[[[UserInformation sharedInstance] objectList] filteredObjectsWithObjectType:kEAObjectTypeBox]];
    [devices unionSet:[[[UserInformation sharedInstance] objectList] filteredObjectsWithObjectType:kEAObjectTypeCamera]];
    [devices unionSet:[[[UserInformation sharedInstance] objectList] filteredObjectsWithObjectType:kEAObjectTypeLight]];
    [devices unionSet:[[[UserInformation sharedInstance] objectList] filteredObjectsWithObjectType:kEAObjectTypeSocket]];
    [devices unionSet:[[[UserInformation sharedInstance] objectList] filteredObjectsWithObjectType:kEAObjectTypeWecon]];
    
    if (![self disableNotifier] && [devices count] < 100) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FoundDevice object:device];
    }
}

- (void)handleDidEnterBackgroundNotification:(NSNotification *)notification {
    dispatch_suspend(udp_processing_queue());
}

- (void)handleWillEnterForegroundNotification:(NSNotification *)notification {
    dispatch_resume(udp_processing_queue());
}

@end
