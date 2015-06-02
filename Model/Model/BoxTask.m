#import "BoxTask.h"
#import "SingleBoxTask.h"

#if !__has_feature(objc_arc)
#error BoxTask must be built with ARC.
// You can turn on ARC for only BoxTask.m by adding -fobjc-arc to the build phase.
#endif

@implementation BoxTask

#pragma mark - Property
@synthesize identity = _identity;
@synthesize week = _week;
@synthesize taskType = _taskType;
@synthesize taskEnable = _taskEnable;
@synthesize alarmTimeType = _alarmTimeType;

- (id)init {
    if (self = [super init]) {
        self.powerOnTask = [[SingleBoxTask alloc] init];
        self.powerOnTask.command = kOperateCommandOn;
        self.powerOffTask = [[SingleBoxTask alloc] init];
        self.powerOffTask.command = kOperateCommandOff;
    }
    return self;
}

@end
