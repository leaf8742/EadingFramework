#import "ModelExtras.h"
#import "APManager.h"
#import "DocumentManager.h"

kAttachmentType attachmentTypeWithString(NSString *string) {
    kAttachmentType result;
    if ([string isEqualToString:@"01010000"]) {
        result = kAttachmentTypeBody;
    } else if ([string isEqualToString:@"02010000"]) {
        result = kAttachmentTypeCarbonMonoxide;
    } else if ([string isEqualToString:@"03010000"]) {
        result = kAttachmentTypeRemote;
    } else if ([string isEqualToString:@"02020000"]) {
        result = kAttachmentTypeMethane;
    } else if ([string isEqualToString:@"04010000"]) {
        result = kAttachmentTypeTemperatureHumidity;
    } else if ([string isEqualToString:@"02030000"]) {
        result = kAttachmentTypeSmog;
    } else if ([string isEqualToString:@"02040000"]) {
        result = kAttachmentTypeFormaldehyde;
    } else {
        result = kAttachmentTypeNone;
    }
    
    return result;
}

BOOL deviceIsReady(id<WirelessGeneral> device) {
    return [[[APManager sharedInstance] ssidForConnectedNetwork] isEqualToString:[device ssid]];
}

BOOL deviceHasAuthority(id<DeviceGeneral> device) {
    return device.authority == kAuthoritySuper || device.authority == kAuthorityAdministrator;
}

kAuthority unauthorized() {
    return [[UserInformation sharedInstance] accountType] == kAccountTypeGuest ? kAuthorityGuest : kAuthorityCustomer;
}

NSDictionary *productType(NSString *string) {
    kEAObjectType type = kEAObjectTypeUnknown;
    kSubType subType = kSubTypeUnknown;
    
    switch ([string integerValue]) {
        case 1:
        case 12:
        case 15:
        case 19:
            type = kEAObjectTypeBox;
            subType = kSubTypeBoxGeneral;
            break;
        case 2:
            type = kEAObjectTypeLight;
            break;
        case 5:
        case 18:
            type = kEAObjectTypeBox;
            subType = kSubTypeNetwork;
            break;
        case 11:
            type = kEAObjectTypeSocket;
            break;
        case 13:
            type = kEAObjectTypeCamera;
            break;
        case 16:
        case 20:
        case 21:
            type = kEAObjectTypeBox;
            subType = kSubTypeMango;
            break;
        default:
            break;
    }
    
    return @{@"type": [NSNumber numberWithInteger:type], @"subType": [NSNumber numberWithInteger:subType]};
}

extern void objectSetType(id<EAObjectGeneral> object, NSString *string) {
    NSDictionary *dictionary = productType(string);
    [object setObjectType:[dictionary[@"type"] integerValue]];
    [object setSubType:[dictionary[@"subType"] integerValue]];
}

extern UIImage *objectImage(id object) {
    if ([object conformsToProtocol:@protocol(EAObjectGeneral)]) {
        // EAObjectGeneral对象处理
        if ([object picture] == nil || [[object picture] isEqualToString:@""]) {
            // 默认图片处理
            switch ([object objectType]) {
                case kEAObjectTypeBox:
                    switch ([object subType]) {
                        case kSubTypeBoxGeneral:
                            return [UIImage imageNamed:@"BoxIcon"];
                        case kSubTypeNetwork:
                            return [UIImage imageNamed:@"NetworkIcon"];
                        case kSubTypeMango:
                            return [UIImage imageNamed:@"MangoIcon"];
                        default:
                            return nil;
                    }
                case kEAObjectTypeCamera:
                    return [UIImage imageNamed:@"CameraIcon"];
                case kEAObjectTypeLight:
                    return [UIImage imageNamed:@"LightIcon"];
                case kEAObjectTypeSocket:
                    return [UIImage imageNamed:@"SocketIcon"];
                default:
                    return nil;
            }
        } else {
            // 设置图片处理
            return [DocumentManager getPhotoFromName:[object picture]];
        }
    } else if ([object conformsToProtocol:@protocol(AttachmentGeneral)]) {
        // 配件对象处理
        switch ([(id<AttachmentGeneral>)object type]) {
            case kAttachmentTypeBody:
                return [UIImage imageNamed:@"BodyIcon"];
            case kAttachmentTypeCarbonMonoxide:
                return [UIImage imageNamed:@"CarbonMonoxideIcon"];
            case kAttachmentTypeRemote:
                return [UIImage imageNamed:@"RemoteIcon"];
            default:
                return nil;
        }
    } else {
        return nil;
    }
}

extern NSInteger hexToDecimal(NSString *hexString) {
    if (hexString && ![hexString isEqualToString:@""]) {
        return strtoul([hexString UTF8String], 0, 16);
    }
    return 0;
}

extern NSString *decimalToHex(NSInteger decimal) {
    NSString *nLetterValue;
    NSString *hexString = @"";
    int ttmpig;
    for (int i = 0; i < 9; i++) {
        ttmpig = decimal % 16;
        decimal = decimal / 16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue = @"A";break;
            case 11:
                nLetterValue = @"B";break;
            case 12:
                nLetterValue = @"C";break;
            case 13:
                nLetterValue = @"D";break;
            case 14:
                nLetterValue = @"E";break;
            case 15:
                nLetterValue = @"F";break;
            default:
                nLetterValue = [[NSString alloc] initWithFormat:@"%d",ttmpig];
                
        }
        
        hexString = [nLetterValue stringByAppendingString:hexString];
        if (decimal == 0) {
            break;
        }
    }
    
    if ([hexString length] == 1) {
        hexString = [@"0" stringByAppendingString:hexString];
    }
    
    return hexString;
}

extern void buildRepeat(NSString *repeat, id<TaskGeneral> task) {
    [task setWeek:0];
    for (NSUInteger week = 1; week != 8; ++week) {
        if ([repeat rangeOfString:[NSString stringWithFormat:@"%d", week]].length == 1) {
            task.week |= (1 << (week - 1));
        }
    }
}
