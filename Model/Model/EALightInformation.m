#import "EALightInformation.h"
#import "APManager.h"
#import "Reachability.h"
#import "ModelExtras.h"

#if !__has_feature(objc_arc)
#error EALightInformation must be built with ARC.
// You can turn on ARC for only EALightInformation.m by adding -fobjc-arc to the build phase.
#endif

@implementation EALightInformation

#pragma mark - Property
@synthesize title = _title;
@synthesize objectType = _objectType;
@synthesize subType = _subType;
@synthesize electricType = _electricType;
@synthesize electricTypeCode = _electricTypeCode;
@synthesize picture = _picture;
@synthesize mementoPicture = _mementoPicture;
@synthesize floor = _floor;
@synthesize place = _place;
@synthesize identity = _identity;
@synthesize remark = _remark;
@synthesize history = _history;
@synthesize timestamp = _timestamp;
@synthesize creationDate = _creationDate;

@synthesize ip = _ip;
@synthesize ssid = _ssid;
@synthesize ready = _ready;

@synthesize restoreFactory = _restoreFactory;
@synthesize online = _online;
@synthesize locked = _locked;
@synthesize invalide = _invalide;
@synthesize attachmentList = _attachmentList;
@synthesize authority = _authority;
@synthesize users = _users;
@synthesize attachment = _attachment;
@synthesize firmwareVer = _firmwareVer;
@synthesize isNeedUpdate = _isNeedUpdate;
@synthesize factoryAddr = _factoryAddr;
@synthesize brand = _brand;
@synthesize model = _model;

#pragma mark - Lifecycle
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, identity: %@, title: %@>", NSStringFromClass([self class]), self, self.identity, self.title];
}

- (id)init {
    if (self = [super init]) {
        self.creationDate = [NSDate date];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        [self addObserver:self forKeyPath:@"ssid" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

- (id)initWithIdentity:(NSString *)identity {
    if (self = [self init]) {
        self.identity = identity;
        self.objectType = kEAObjectTypeLight;
    }
    return self;
}

- (UIColor *)color {
    return [UIColor colorWithRed:hexToDecimal(self.colors[@"rd"]) / 100.0 green:hexToDecimal(self.colors[@"gr"]) / 100.0  blue:hexToDecimal(self.colors[@"bu"]) / 100.0  alpha:1];
}

- (void)updateReady {
    _ready = [[[APManager sharedInstance] ssidForConnectedNetwork] isEqualToString:_ssid];
}

/// @brief 在网络环境变换时，判断本设备是否在当前局域网内
- (void)reachabilityChanged:(NSNotification *)notification {
    [self updateReady];
}

/// @brief 在应用程序返回时，判断本设备是否在当前局域网内
- (void)appWillEnterForground:(NSNotification *)notification {
    [self updateReady];
}

#pragma mark - Observer method
/// @brief 在外部设置自己的ssid时，判断本设备是否在当前局域网内
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"ssid"]) {
        [self updateReady];
    }
}


@end
