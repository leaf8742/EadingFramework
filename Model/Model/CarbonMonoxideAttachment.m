#import "CarbonMonoxideAttachment.h"

#if !__has_feature(objc_arc)
#error CarbonMonoxideAttachment must be built with ARC.
// You can turn on ARC for only CarbonMonoxideAttachment.m by adding -fobjc-arc to the build phase.
#endif

@implementation CarbonMonoxideAttachment

#pragma mark - Property
@synthesize type = _type;
@synthesize identity = _identity;
@synthesize place = _place;
@synthesize floor = _floor;
@synthesize history = _history;
@synthesize historyCount = _historyCount;
@synthesize workEnabled = _workEnabled;
@synthesize pushEnabled = _pushEnabled;
@synthesize beginTime = _beginTime;
@synthesize endTime = _endTime;
@synthesize beginNotifyTime = _beginNotifyTime;
@synthesize endNotifyTime = _endNotifyTime;
@synthesize value = _value;

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, identity: %@>", NSStringFromClass([self class]), self, self.identity];
}

- (id)initWithIdentity:(NSString *)identity {
    if (self = [self init]) {
        self.identity = identity;
        self.type = kAttachmentTypeCarbonMonoxide;
    }
    return self;
}

@end
