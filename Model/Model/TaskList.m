#import "Model.h"

#if !__has_feature(objc_arc)
#error TaskList must be built with ARC.
// You can turn on ARC for only TaskList.m by adding -fobjc-arc to the build phase.
#endif

@implementation TaskList

- (id)init {
    if (self = [super init]) {
        self.tasks = [NSMutableSet set];
    }
    return self;
}

- (id<TaskGeneral>)taskWithIdentity:(NSString *)identity {
    NSSet *filtered = [self.tasks filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<TaskGeneral> evaluatedObject, NSDictionary *bindings) {
        return [[evaluatedObject identity] isEqualToString:identity];
    }]];
    
    NSAssert([filtered count] <= 1, @"两条一样的了");
    return [filtered anyObject];
}

@end
