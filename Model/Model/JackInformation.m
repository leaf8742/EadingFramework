#import "JackInformation.h"
#import "TaskList.h"

#if !__has_feature(objc_arc)
#error JackInformation must be built with ARC.
// You can turn on ARC for only JackInformation.m by adding -fobjc-arc to the build phase.
#endif

@implementation JackInformation

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

- (id)init {
    if (self = [super init]) {
        self.creationDate = [NSDate date];
    }
    return self;
}

- (id)initWithIdentity:(NSString *)identity {
    if (self = [self init]) {
        self.identity = identity;
        self.objectType = kEAObjectTypeJack;
    }
    return self;
}

#pragma mark - Property
- (TaskList *)taskList {
    if (!_taskList) {
        _taskList = [[TaskList alloc] init];
    }
    
    return _taskList;
}

@end
