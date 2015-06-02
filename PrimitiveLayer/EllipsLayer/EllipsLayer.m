#import "EllipsLayer.h"

@implementation EllipsLayer

- (void)makeWithDictionaryRepresentation:(NSDictionary *)dict {
    CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)[dict objectForKey : @"rect"], &_rect);
}

- (void)display {
    if (self.path) {
        CGPathRelease(self.path);
        self.path = nil;
    }

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, _rect);
    self.path = path;
}

@end
