#import "LightTask.h"

#if !__has_feature(objc_arc)
#error LightTask must be built with ARC.
// You can turn on ARC for only LightTask.m by adding -fobjc-arc to the build phase.
#endif

@implementation LightTask

#pragma mark - Property
@synthesize identity = _identity;
@synthesize week = _week;

@end
