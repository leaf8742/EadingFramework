//
//  ApplianceInformation.m
//  com.eading.wireless
//
//  Created by Q on 15/1/14.
//
//

#import "Model.h"

@implementation ApplianceInformation

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
@synthesize brand = _brand;
@synthesize model = _model;

#pragma mark - Lifecycle
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, identity: %@, title: %@>", NSStringFromClass([self class]), self, self.identity, self.title];
}

- (instancetype)init {
    if (self = [super init]) {
        self.userList = [[UserList alloc] init];
        self.recentlyTask = [[ApplianceTask alloc] init];
    }
    
    return self;
}

- (void)analyzeDeviceStateWithCode:(NSString *)code {
    self.devicePowerOn = [code rangeOfString:@"01"].length == 2;
    self.device.locked = [code rangeOfString:@"03"].length == 2;
    self.device.online = !([code rangeOfString:@"05"].length == 2);
}

#pragma mark - Property
- (NSMutableSet *)combineIdentities {
    if (!_combineIdentities) {
        _combineIdentities = [NSMutableSet set];
    }
    
    return _combineIdentities;
}

- (NSString *)title {
    if (_title.length == 0) {
        _title = @"";
    }
    
    return _title;
}

@end
