#import "PolygonLayer.h"

@implementation PolygonLayer

- (id)init {
    if (self = [super init]) {
        self.points = [NSMutableArray array];
    }
    return self;
}

- (void)makeWithDictionaryRepresentation:(NSDictionary *)dict {
    NSArray* pointsArray = [dict objectForKey:@"points"];
    
    for (NSDictionary* pointsDict in pointsArray) {
        CGPoint point;
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)pointsDict, &point);
        [self.points addObject : [NSValue valueWithCGPoint:point]];
    }
}

- (void)display{
    if (self.path) {
        CGPathRelease(self.path);
        self.path = nil;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint begin = [[self.points firstObject] CGPointValue];
    CGPathMoveToPoint(path, NULL, begin.x, begin.y);
    for (int i = 1; i < [self.points count] - 1; i++) {
        CGPoint point   = [(NSValue *)[self.points objectAtIndex:i] CGPointValue];
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    CGPathAddLineToPoint(path, NULL, begin.x, begin.y);
    self.path = path;
}

@end
