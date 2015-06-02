#import "Model.h"

#if __has_feature(objc_arc)
#error UserInformation must be built with No ARC.
// You can turn off ARC for only UserInformation.m by adding -fno-objc-arc to the build phase.
#endif

@interface UserInformation()

+ (NSMutableSet *)users;

@end


@implementation UserInformation

+ (instancetype)sharedInstance {
    static UserInformation *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [NSAllocateObject([self class], 0, NULL) init];
    });
    return sharedClient;
}

+ (NSMutableSet *)users {
    static NSMutableSet *users = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        users = [[NSMutableSet set] retain];
    });
    return users;
}

- (id)init {
    if (self = [super init]) {
        self.objectList = [[EAObjectList alloc] init];
        [self.objectList addObserver:self
                          forKeyPath:@"objects"
                             options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                             context:nil];
        [self.objectList addObserver:self
                          forKeyPath:@"appliances"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
    }
    return self;
}

- (id)initWithMobile:(NSString *)mobile {
    if (self = [self init]) {
        self.mobile = mobile;
        [[UserInformation users] addObject:self];
    }
    return self;
}

- (id)initWithEmail:(NSString *)email {
    if (self = [self init]) {
        self.email = email;
        [[UserInformation users] addObject:self];
    }
    return self;
}

+ (instancetype)getUserWithMobile:(NSString *)mobile {
    if ([mobile isEqualToString:@""]) return nil;
    
    NSSet *set = [self.users filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UserInformation *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.mobile isEqualToString:mobile];
    }]];
    NSAssert([set count] <= 1, @"重复用户");
    
    return [set anyObject];
}

+ (instancetype)getUserWithEmail:(NSString *)email {
    if ([email isEqualToString:@""]) return nil;
    NSSet *set = [self.users filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UserInformation *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.mobile isEqualToString:email];
    }]];
    NSAssert([set count] <= 1, @"重复用户");
    
    return [set anyObject];
}

- (void)initialize {
#warning TODO
}

- (void)synchronousAppliancesAndDevices:(NSDictionary *)change {
    [self.objectList.appliances enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        ApplianceInformation *appliance = (ApplianceInformation *)obj;
        NSSet *device = [self.objectList.objects filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"identity == %@", appliance.device.identity]];
        if (device.count > 0) {
            BOOL online = appliance.device.online;
            BOOL locked = appliance.device.locked;
            appliance.device = [device anyObject];
            appliance.device.online = online;
            appliance.device.locked = locked;
        }
    }];
    
    if ([change[NSKeyValueChangeKindKey] integerValue] == NSKeyValueChangeRemoval) {
        NSMutableSet *removeSet = [NSMutableSet set];
        NSMutableSet *tempSet = [NSMutableSet setWithSet:change[NSKeyValueChangeOldKey]];
        [tempSet minusSet:self.objectList.objects];
        [tempSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            id<EAObjectGeneral>device = obj;
            NSSet *appliance = [self.objectList.appliances filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                ApplianceInformation *appliance = (ApplianceInformation *)evaluatedObject;
                return [appliance.device.identity isEqualToString:device.identity];
            }]];
            
            if (appliance.count > 0) {
                [removeSet addObject:[appliance anyObject]];
            }
        }];
        
        [[self.objectList mutableSetValueForKey:@"appliances"] minusSet:removeSet];
    }
}

- (void)reloadObjectList {
    [self.objectList removeObserver:self forKeyPath:@"objects"];

    self.objectList = [[EAObjectList alloc] init];
    [self.objectList addObserver:self
                      forKeyPath:@"objects"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:nil];
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"objects"]) {
        [self synchronousAppliancesAndDevices:change];
    }
}

#pragma mark - Memory Management
- (void)dealloc {
    [self.objectList removeObserver:self forKeyPath:@"objects"];
    
    [_objectList release];
    [_email release];
    [_mobile release];
    [_name release];
    [_gender release];
    [_passwd release];
    [_sessionID release];
    [_deviceTokenString release];
    [_colorScheme release];
    [_picture release];
    
    [super dealloc];
}

@end
