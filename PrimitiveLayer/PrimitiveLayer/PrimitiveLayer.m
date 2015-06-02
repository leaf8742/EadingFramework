#import "PrimitiveLayer.h"
#import "LineSegmentLayer.h"
#import "RectangleLayer.h"
#import "CircleLayer.h"
#import "EllipsLayer.h"
#import "ArcLayer.h"
#import "PolygonLayer.h"
#import "ColorSchemeManager.h"

@implementation PrimitiveLayer

+ (void)appearance:(NSString *)appearance drawWithBoard:(CALayer *)board {
    NSURL *path =  [[NSBundle mainBundle]URLForResource:@"Scheme" withExtension:@"plist"];
    NSDictionary *symbols = [NSDictionary dictionaryWithContentsOfURL:path];
    NSDictionary *symbol = [symbols objectForKey:appearance];
    NSArray *primitives = [symbol objectForKey:@"primitives"];
    
    for (NSDictionary *dictionary in primitives) {
        PrimitiveLayer *layer = [PrimitiveLayer primitiveFromDictionaryRepresent:dictionary];
        [board addSublayer:layer];
        [layer setNeedsDisplay];
    }
}

+ (PrimitiveLayer *)primitiveFromDictionaryRepresent:(NSDictionary *)dictionary {
    PrimitiveLayer *primitive;
    switch ([[dictionary objectForKey:@"kind"] integerValue]) {
        case kPrimitiveKindLineSegment: {
            primitive = [[LineSegmentLayer alloc] init];
        }
            break;
        case kPrimitiveKindRectangle: {
            primitive = [[RectangleLayer alloc] init];
        }
            break;
        case kPrimitiveKindCircle: {
            primitive = [[CircleLayer alloc] init];
        }
            break;
        case kPrimitiveKindEllips: {
            primitive = [[EllipsLayer alloc] init];
        }
            break;
        case kPrimitiveKindArc: {
            primitive = [[ArcLayer alloc] init];
        }
            break;
        case kPrimitiveKindPolygon: {
            primitive = [[PolygonLayer alloc] init];
        }
            break;
        default: {
            primitive = nil;
        }
            break;
    }

    // 画笔颜色
    if ([dictionary objectForKey:@"strokeColor"]) {
        [primitive setStrokeColor:[ColorSchemeManager colorWithDescription:[dictionary objectForKey:@"strokeColor"]].CGColor];
    } else {
        [primitive setStrokeColor:[[UIColor blackColor] CGColor]];
    }

    // 填充颜色
    if ([dictionary objectForKey:@"fillColor"]) {
        [primitive setFillColor:[ColorSchemeManager colorWithDescription:[dictionary objectForKey:@"fillColor"]].CGColor];
    } else {
        [primitive setFillColor:[[UIColor clearColor] CGColor]];
    }

    // 画笔宽度
    if ([dictionary objectForKey:@"lineWidth"]) {
        [primitive setLineWidth:[[dictionary objectForKey:@"lineWidth"] floatValue]];
    } else {
        [primitive setLineWidth:0.5];
    }

    // 读取属性
    [primitive makeWithDictionaryRepresentation:dictionary];
    return primitive;
}

- (void)makeWithDictionaryRepresentation:(NSDictionary *)dictionary {
    NSAssert(NO, @"不允许直接创建基础图元");
}

@end
