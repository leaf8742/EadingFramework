#import "HalfHourNumberInputValidator.h"

@implementation HalfHourNumberInputValidator

- (BOOL)validateInput:(UITextField *)input error:(NSError **)error {
    return YES;
}

- (BOOL)validateInput:(UITextField *)input shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string error:(NSError **)error {
    // 最多2位
    NSString *result = [input.text stringByReplacingCharactersInRange:range withString:string];

    if (result.length > 2 || [result integerValue] > 12) {
        if (error != nil) {
            NSString *description = NSLocalizedString(@"拼写检查错误", @"");
            NSString *reason = NSLocalizedString(@"大于2个字符", @"");
            NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [NSError errorWithDomain:InputValidationErrorDomain code:1001 userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text length]) {
        textField.text = [NSString stringWithFormat:@"%02d", [textField.text integerValue]];
    } else {
        textField.text = @"00";
    }
}

@end
