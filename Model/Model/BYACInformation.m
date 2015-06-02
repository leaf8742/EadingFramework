#import "BYACInformation.h"
#import "BoxTask.h"
#import "SingleBoxTask.h"

@implementation BYACInformation

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
@synthesize brand = _brand;
@synthesize model = _model;

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
@synthesize firmwareVer = _firmwareVer;
@synthesize isNeedUpdate = _isNeedUpdate;
@synthesize factoryAddr = _factoryAddr;
@synthesize attachment = _attachment;

- (id)initWithIdentity:(NSString *)identity {
    if (self = [self init]) {
        self.identity = identity;
        self.objectType = kEAObjectTypeBYAC;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        self.task = [[BoxTask alloc] init];
        self.creationDate = [NSDate date];
        self.fanSpeed = kAirConditionerFanSpeedAuto;
        self.mode = kAirConditionerModeAuto;
        self.temperature = 16;
    }
    return self;
}

- (NSInteger)modeString {
    NSInteger power = self.powerOn ? 1 : 0;
    NSInteger mode = self.mode << 1;
    NSInteger fanSpeed = self.fanSpeed << 4;
    NSInteger sleep = self.sleep ? 1 << 6 : 0;
    NSInteger swing = self.swing ? 1 << 7 : 0;
    
    return power | mode | fanSpeed | sleep | swing;
}

- (void)updateMode:(NSInteger)mode {
    // 摆风
    self.swing = mode & 0x80;
    
    // 睡眠模式
    self.sleep = mode & 0x40;
    
    // 风速
    switch (mode & 0x30) {
        case 0:
            self.fanSpeed = kAirConditionerFanSpeedAuto;
            break;
        case 1:
            self.fanSpeed = kAirConditionerFanSpeedLow;
            break;
        case 2:
            self.fanSpeed = kAirConditionerFanSpeedMed;
            break;
        case 3:
            self.fanSpeed = kAirConditionerFanSpeedHigh;
            break;
        default:
            break;
    }
    
    // 模式
    switch (mode & 0x0e) {
        case 0:
            self.mode = kAirConditionerModeUnknown;
            break;
        case 1:
            self.mode = kAirConditionerModeAuto;
            break;
        case 2:
            self.mode = kAirConditionerModeCool;
            break;
        case 3:
            self.mode = kAirConditionerModeDry;
            break;
        case 4:
            self.mode = kAirConditionerModeFan;
            break;
        case 5:
            self.mode = kAirConditionerModeHeat;
            break;
        default:
            break;
    }
    
    // 开关机
    self.powerOn = mode & 1;
}

- (void)updateTask:(NSDictionary *)response {
    NSUInteger powerOn = [response[@"timeon"] integerValue];
    NSUInteger powerOff = [response[@"timeoff"] integerValue];
    NSDate *currentDate = [NSDate date];
    self.task.powerOnTask.time = [currentDate dateByAddingTimeInterval:powerOn * 30 * 60];
    self.task.powerOnTask.enabled = (powerOn != 0);
    self.task.powerOffTask.time = [currentDate dateByAddingTimeInterval:powerOff * 30 * 60];
    self.task.powerOffTask.enabled = (powerOff != 0);
}

@end
