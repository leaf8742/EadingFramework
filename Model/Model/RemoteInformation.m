#import "RemoteInformation.h"

#if !__has_feature(objc_arc)
#error RemoteInformation must be built with ARC.
// You can turn on ARC for only RemoteInformation.m by adding -fobjc-arc to the build phase.
#endif

@implementation RemoteInformation

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

#pragma mark - Lifecycle
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, identity: %@, title: %@>", NSStringFromClass([self class]), self, self.identity, self.title];
}

- (id)init {
    if (self = [super init]) {
        self.creationDate = [NSDate date];
        self.keymap = [NSMutableArray array];
    }
    return self;
}

- (id)initWithIdentity:(NSString *)identity {
    if (self = [self init]) {
        self.identity = identity;
        self.objectType = kEAObjectTypeRemote;
    }
    return self;
}

- (NSMutableDictionary *)dictionaryWithKey:(NSString *)key {
    NSArray *fetchObjects = [self.keymap filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"key == %@", key]];
    NSAssert([fetchObjects count] < 2, @"有2个相同key");
    if ([fetchObjects count]) {
        return [fetchObjects firstObject];
    } else {
        return nil;
    }
}

//- (void)addKeyValue:(NSDictionary *)dictionary {
//    RemoteDictionaryRecord *remoteDictionaryRecord = [record remoteDictionaryWithKey:[dictionary objectForKeyedSubscript:@"key"]];
//    if (remoteDictionaryRecord == nil) {
//        remoteDictionaryRecord = [RemoteDictionaryRecord insertNewObjectForEntityForName];
//    }
//    remoteDictionaryRecord.key = [dictionary objectForKey:@"key"];
//    remoteDictionaryRecord.value = [dictionary objectForKey:@"value"];
//    remoteDictionaryRecord.sort = [dictionary objectForKey:@"sort"];
//    remoteDictionaryRecord.img = [dictionary objectForKey:@"img"];
//    remoteDictionaryRecord.title = [dictionary objectForKey:@"title"];
//    remoteDictionaryRecord.remote = record;
//    [record addKeyValuesObject:remoteDictionaryRecord];
//    [[PersistentManager sharedInstance] saveContext];
//}

//- (void)remoteKeyValue:(NSMutableDictionary *)dictionary {
//    RemoteRecord *record = [RemoteRecord recordWithidentity:self.identity];
//    NSSet *fetchObjects = [record.keyValues filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"key == %@", [dictionary objectForKey:@"key"]]];
//    
//    NSAssert([fetchObjects count] == 1, @"两个相同的key值！！！");
//    RemoteDictionaryRecord *remoteDictionaryRecord = [fetchObjects anyObject];
//    [record removeKeyValuesObject:remoteDictionaryRecord];
//    [[PersistentManager sharedInstance] saveContext];
//}

//- (void)changekeyValue:(NSMutableDictionary *)dictionary keyName:(NSString *)name img:(NSString *)img value:(NSString *)value {
//    // 存入内存模型
//    NSMutableDictionary *dictionaryForKey = [self dictionaryWithKey:[dictionary objectForKey:@"key"]];
//    if (dictionaryForKey == nil) {
//        dictionaryForKey = [NSMutableDictionary dictionary];
//        [dictionaryForKey setValue:@"key" forKey:[dictionary objectForKey:@"key"]];
//        [self.keymap addObject:dictionaryForKey];
//    }
//    [dictionaryForKey setValue:value forKey:@"value"];
//    if (name == nil || [name isEqualToString:@""]) {
//        [dictionaryForKey setValue:@"" forKey:@"title"];
//    }else{
//        [dictionaryForKey setValue:name forKey:@"title"];
//    }
//    
//    // 存入数据库
//    RemoteRecord *record = [RemoteRecord recordWithidentity:self.identity];
//    NSSet *fetchObjects = [record.keyValues filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"key == %@", [dictionary objectForKey:@"key"]]];
//    for (RemoteDictionaryRecord *remoteDictionaryRecord in fetchObjects) {
//        if (name == nil) {
//            remoteDictionaryRecord.title = @"";
//        }else{
//            remoteDictionaryRecord.title = name;
//        }
//        if (img == nil) {
//            remoteDictionaryRecord.img = @"";
//        }else{
//            remoteDictionaryRecord.img = img;
//        }
//        if (value == nil) {
//            remoteDictionaryRecord.value = @"";
//        }else{
//            remoteDictionaryRecord.value = value;
//        }
//    }
//    [[PersistentManager sharedInstance] saveContext];
//}

@end
