#import "NameInputValidator.h"

@implementation NameInputValidator

- (BOOL)validateInput:(UITextField *)input error:(NSError **)error {
    // 最少2位
    if (input.text.length < 2) {
        if (error != nil) {
            NSString *description = NSLocalizedString(nil, @"");
            // qcw localized
            NSString *reason = NSLocalizedString(@"昵称长度2-15位", @"");
            if ([input.text length] == 0) {
                reason = NSLocalizedString(@"请输入昵称", @"");
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
    // 最多16位
    NSString *result = [input.text stringByReplacingCharactersInRange:range withString:string];

    if (result.length > 16) {
        if (error != nil) {
            NSString *description = NSLocalizedString(nil, @"");
            NSString *reason = NSLocalizedString(@"大于15个字符", @"");
            NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [NSError errorWithDomain:InputValidationErrorDomain code:1001 userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}

@end
