#import "LineSegmentLayer.h"

@implementation LineSegmentLayer

- (void)makeWithDictionaryRepresentation:(NSDictionary *)dictionary {
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)[dictionary objectForKey:@"start"], &_start);
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)[dictionary objectForKey:@"end"], &_end);
}

- (void)display{
    if (self.path) {
        CGPathRelease(self.path);
        self.path = nil;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _start.x, _start.y);
    CGPathAddLineToPoint(path, NULL, _end.x, _end.y);
    self.path = path;
}

@end
