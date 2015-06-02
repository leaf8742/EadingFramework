#import "RemarkInputValidator.h"

@implementation RemarkInputValidator

- (BOOL)validateInput:(UITextField *)input shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string error:(NSError **)error {
    // 最多30位
    NSString *result = [input.text stringByReplacingCharactersInRange:range withString:string];
    return [result length] <= 30;
}

@end
