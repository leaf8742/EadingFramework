#import "ServiceRemotes.h"

@implementation ServiceRemotes

- (id)init {
    self = [super init];
    if (self) {
        self.serviceRemotes = [NSMutableArray array];
    }
    return self;
}

+ (ServiceRemotes *)sharedInstance {
    static ServiceRemotes *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[ServiceRemotes alloc] init];
    });
    return sharedClient;
}

- (NSArray *)remoteTitlesWithType:(kRemoteType)type {
    NSArray *fetchObjects = [self.serviceRemotes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"type == %@", [NSNumber numberWithInteger:type]]];
    return fetchObjects;
}

@end
