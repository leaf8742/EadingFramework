#import "Model.h"

#if !__has_feature(objc_arc)
#error AttachmentList must be built with ARC.
// You can turn on ARC for only AttachmentList.m by adding -fobjc-arc to the build phase.
#endif

@interface AttachmentList()

/// @brief 所有的配件
+ (NSMutableSet *)allAttachments;

@end


@implementation AttachmentList

#warning selectedAttachment、attachments设置时，查看其他插座上是否有这个，有的话，要拔掉，因为一个配件只能出现一次

+ (NSMutableSet *)allAttachments {
    static NSMutableSet *allAttachments = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allAttachments = [NSMutableSet set];
    });
    return allAttachments;
}

+ (id<AttachmentGeneral>)attachmentWithIdentity:(NSString *)identity {
    NSSet *filteredObjects = [[self allAttachments] filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<AttachmentGeneral> evaluatedObject, NSDictionary *bindings) {
        return [[evaluatedObject identity] isEqualToString:identity];
    }]];
    NSAssert([filteredObjects count] <= 1, @"添加附件时出错，两条一样的身份标识");
    return [filteredObjects anyObject];
}

+ (id<AttachmentGeneral>)attachmentWithIdentity:(NSString *)identity type:(kAttachmentType)type {
    id<AttachmentGeneral> result = [self attachmentWithIdentity:identity];
    if (result != nil) {
        NSAssert([result type] == type || type == kAttachmentTypeNone, @"查询出错，和被查询的类型不一样");
        return result;
    } else {
        switch (type) {
            case kAttachmentTypeNone:
                break;
            case kAttachmentTypeBody:
                result = [[BodyAttachment alloc] initWithIdentity:identity];
                break;
            case kAttachmentTypeCarbonMonoxide:
                result = [[CarbonMonoxideAttachment alloc] initWithIdentity:identity];
                break;
            case kAttachmentTypeFormaldehyde:
                result = [[FormaldehydeAttachment alloc] initWithIdentity:identity];
                break;
            case kAttachmentTypeMethane:
                result = [[MethaneAttachment alloc] initWithIdentity:identity];
                break;
            case kAttachmentTypeSmog:
                result = [[SmogAttachment alloc] initWithIdentity:identity];
                break;
            case kAttachmentTypeTemperatureHumidity:
                result = [[TemperatureHumidityAttachment alloc] initWithIdentity:identity];
                break;
            case kAttachmentTypeRemote:
                result = [[RemoteAttachment alloc] initWithIdentity:identity];
                break;
            default:
                break;
        }
        [[self allAttachments] addObject:result];
        return result;
    }
}

@end
