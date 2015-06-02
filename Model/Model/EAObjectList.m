#import "Model.h"

#if !__has_feature(objc_arc)
#error EAObjectList must be built with ARC.
// You can turn on ARC for only EAObjectList.m by adding -fobjc-arc to the build phase.
#endif

@interface EAObjectList()

/// @brief 所有的对象
+ (NSMutableSet *)allObjects;

@end


@implementation EAObjectList

- (NSString *)description {
    NSString *selfDescription = [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass([self class]), self];
    NSString *objectsDescription = [[self objects] description];
    NSMutableSet *others = [NSMutableSet setWithSet:[EAObjectList allObjects]];
    [others minusSet:self.objects];
    return [selfDescription stringByAppendingFormat:@"\nobjects:\n%@\nthe othor:\n%@", objectsDescription, [others description]];
}

- (id)init {
    if (self = [super init]) {
        self.objects = [NSMutableSet set];
        self.appliances = [NSMutableSet set];
        self.ChangeRecordArray = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
}

+ (NSMutableSet *)allObjects {
    static NSMutableSet *allObjects = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allObjects = [NSMutableSet set];
    });
    return allObjects;
}

+ (id<EAObjectGeneral>)objectWithIdentity:(NSString *)identity {
    NSSet *filteredObjects = [[self allObjects] filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<EAObjectGeneral> evaluatedObject, NSDictionary *bindings) {
        return [[evaluatedObject identity] isEqualToString:identity];
    }]];
    NSAssert([filteredObjects count] <= 1, @"添加对象时出错，两条一样的身份标识");
    return [filteredObjects anyObject];
}

+ (id<EAObjectGeneral>)objectWithIdentity:(NSString *)identity type:(kEAObjectType)type {
    id<EAObjectGeneral> result = [self objectWithIdentity:identity];
    if (result != nil) {
        NSAssert([result objectType] == type, @"查询出错，和被查询的类型不一样");
        return result;
    } else {
        switch (type) {
            case kEAObjectTypeBox:
                result = [[EABoxInformation alloc] initWithIdentity:identity];
                break;
            case kEAObjectTypeCamera:
                result = [[CameraInformation alloc] initWithIdentity:identity];
                break;
            case kEAObjectTypeLight:
                result = [[EALightInformation alloc] initWithIdentity:identity];
                break;
            case kEAObjectTypeSocket:
                result = [[EASocketInformation alloc] initWithIdentity:identity];
                break;
            case kEAObjectTypeRemote:
                result = [[RemoteInformation alloc] initWithIdentity:identity];
                break;
            case kEAObjectTypeProfile:
                NSAssert(NO, @"情景模式需要确定是哪种才能创建(TimingProfile / EventProfile)");
                break;
            case kEAObjectTypeWecon:
                NSAssert(NO, @"微控的模型还没创建");
                break;
            case kEAObjectTypeBYAC:
                result = [[BYACInformation alloc] initWithIdentity:identity];
                break;
            default:
                break;
        }
        [[self allObjects] addObject:result];
        return result;
    }
}

+ (id<EAObjectGeneral>)objectWithAttachmentIdentity:(NSString *)identity {
    NSAssert(identity != nil, @"唯一标识为空");
    NSSet *filteredObjects = [[self allObjects] filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<EAObjectGeneral> evaluatedObject, NSDictionary *bindings) {
        BOOL wireless = [evaluatedObject conformsToProtocol:@protocol(DeviceGeneral)];
        if (wireless) {
            if ([[[(id<DeviceGeneral>)evaluatedObject attachment] identity] isEqualToString:identity]) {
                return YES;
            }
        }
        return NO;
    }]];
    NSAssert([filteredObjects count] == 1, @"被查询附件有且只有1个");

    return [filteredObjects anyObject];
}

- (NSArray *)intelligenceDevices {
    NSMutableSet *devices = [NSMutableSet set];
    [devices unionSet:[self filteredObjectsWithObjectType:kEAObjectTypeBox]];
    [devices unionSet:[self filteredObjectsWithObjectType:kEAObjectTypeCamera]];
    [devices unionSet:[self filteredObjectsWithObjectType:kEAObjectTypeLight]];
    [devices unionSet:[self filteredObjectsWithObjectType:kEAObjectTypeSocket]];
    
    NSMutableSet *remoteAttachments = [NSMutableSet set];
    for (id<DeviceGeneral, WirelessGeneral, EAObjectGeneral> device in devices) {
        if ([[device attachment] type] == kAttachmentTypeRemote) {
            [remoteAttachments addObject:[device attachment]];
        }
    }
    
    NSMutableSet *result = [NSMutableSet set];
    [result unionSet:devices];
    [result unionSet:remoteAttachments];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES comparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[RemoteAttachment class]]) {
            if ([obj2 isKindOfClass:[RemoteAttachment class]])
                return NSOrderedSame;
            else
                return NSOrderedDescending;
        } else if ([obj2 isKindOfClass:[RemoteAttachment class]]) {
            return NSOrderedAscending;
        } else {
            return [[NSNumber numberWithInteger:[obj1 objectType]] compare:[NSNumber numberWithInteger:[obj2 objectType]]];
        }
    }];
    
    return [result sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (NSSet *)filteredObjectsWithObjectType:(kEAObjectType)type {
    return [[self objects] filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<EAObjectGeneral> evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject objectType] == type;
    }]];
}

- (ApplianceInformation *)applianceWithID:(NSString *)applianceID {
    __block ApplianceInformation *appliance;
    [self.appliances enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([((ApplianceInformation *)obj).identity isEqualToString:applianceID]) {
            appliance = obj;
            *stop = YES;
        }
    }];
    
    return appliance;
}

@end
