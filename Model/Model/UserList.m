#import "Model.h"

@implementation UserList

- (id)init {
    if (self = [super init]) {
        self.users = [NSMutableSet set];
    }
    return self;
}

- (UserAuthority *)userWithMobile:(NSString *)mobile email:(NSString *)email {
    NSAssert(![mobile isEqualToString:@""] || ![email isEqualToString:@""], @"同时为空");
    
    NSSet *filteredSet = [self.users filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UserAuthority *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.user.mobile isEqualToString:mobile] || [evaluatedObject.user.email isEqualToString:email];
    }]];
    NSAssert([filteredSet count] <= 1, @"两个一样的用户");
    
    UserAuthority *result = [filteredSet anyObject];
    if (result == nil) {
        // 在列表中查找不到UserAuthority时，新建一个
        // 通过mobile和email查找UserInformation。如果查找不到，新建一个
        result = [[UserAuthority alloc] init];
        UserInformation *user = [UserInformation getUserWithMobile:mobile];
        if (user == nil) {
            [UserInformation getUserWithEmail:email];
        }
        if (user == nil) {
            if (![mobile isEqualToString:@""]) {
                user = [[UserInformation alloc] initWithMobile:mobile];
            } else {
                user = [[UserInformation alloc] initWithEmail:email];
            }
        }
        user.email = email;
        user.mobile = mobile;
        result.user = user;
        
        return result;
    } else {
        return result;
    }
}

@end
