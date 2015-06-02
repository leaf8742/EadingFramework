#import "ProfileNameInputValidator.h"

@implementation ProfileNameInputValidator

- (BOOL)validateInput:(UITextField *)input error:(NSError **)error {
    NSString *result = [input.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    // 最少2位
    if (result.length < 2) {
        if (error != nil) {
            NSString *description = NSLocalizedString(nil, @"");
            NSString *reason = NSLocalizedString(@"情景模式名称至少2位", @"");
            if ([input.text length] == 0) {
                reason = NSLocalizedString(@"情景模式名称至少2位", @"");
            }
            NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [NSError errorWithDomain:InputValidationErrorDomain code:1001 userInfo:userInfo];
        }
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validateInput:(UITextField *)input shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string error:(NSError **)error {
    NSString *result = [input.text stringByReplacingCharactersInRange:range withString:string];

//    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@" "] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];

    if ([string rangeOfString:@" "].length) {
        // 不允许出现空格
        if (error != nil) {
            NSString *description = NSLocalizedString(@"拼写检查错误", @"");
            NSString *reason = NSLocalizedString(@"不允许有空格", @"");
            NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [NSError errorWithDomain:InputValidationErrorDomain code:1001 userInfo:userInfo];
        }
        return NO;
    } else if (result.length > 6) {
        // 最多6位
        if (error != nil) {
            NSString *description = NSLocalizedString(@"拼写检查错误", @"");
            NSString *reason = NSLocalizedString(@"大于6个字符", @"");
            NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [NSError errorWithDomain:InputValidationErrorDomain code:1001 userInfo:userInfo];
        }
        return NO;
    } else {
        return YES;
    }
}

@end
