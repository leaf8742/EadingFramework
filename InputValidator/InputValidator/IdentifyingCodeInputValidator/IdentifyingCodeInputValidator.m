#import "IdentifyingCodeInputValidator.h"

@implementation IdentifyingCodeInputValidator

- (BOOL)validateInput:(UITextField *)input error:(NSError **)error {
    // 最少4位
    if (input.text.length < 4) {
        if (error != nil) {
            NSString *description = NSLocalizedString(nil, @"");
            NSString *reason = NSLocalizedString(@"请输入4位数字验证码", @"");
            if ([input.text length] == 0) {
                reason = NSLocalizedString(@"请输入验证码", @"");
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
    // 最多4位
    NSString *result = [input.text stringByReplacingCharactersInRange:range withString:string];

    if (result.length > 4) {
        if (error != nil) {
            NSString *description = NSLocalizedString(@"拼写检查错误", @"");
            NSString *reason = NSLocalizedString(@"大于4个字符", @"");
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
