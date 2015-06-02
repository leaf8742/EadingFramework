#import "CustomTextField.h"
#import <objc/runtime.h>

#if __has_feature(objc_arc)
#error CustomTextField must be built with ARC.
// You can turn off ARC for only CustomTextField.m by adding -fno-objc-arc to the build phase.
#endif

static const void *mementoFrameValueKey = &mementoFrameValueKey;

@interface NSObject(keyboardAnimation)

@property (retain, nonatomic) NSValue *mementoFrameValue;

@property (assign, nonatomic) CGRect mementoFrame;

@end


@implementation NSObject(keyboardAnimation)

- (NSValue *)mementoFrameValue {
    return objc_getAssociatedObject(self, mementoFrameValueKey);
}

- (void)setMementoFrameValue:(NSValue *)value{
    objc_setAssociatedObject(self, mementoFrameValueKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)mementoFrame {
    return [self.mementoFrameValue CGRectValue];
}

- (void)setMementoFrame:(CGRect)mementoFrame {
    self.mementoFrameValue = [NSValue valueWithCGRect:mementoFrame];
}

@end


@implementation CustomTextField

- (id)init {
    self = [super init];
    if (self) {
        self.textColor = [UIColor colorWithWhite:150.0 / 255.0 alpha:1];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor colorWithWhite:150.0 / 255.0 alpha:1];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.textColor = [UIColor colorWithWhite:150.0 / 255.0 alpha:1];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    [self drawTextInRect:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    [self drawTextInRect:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (BOOL)validate {
    NSError *error = nil;
    BOOL validationResult;
    
    if (!(validationResult = [self validateWithError:&error])) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    
    return validationResult;
}

- (BOOL)validateWithError:(NSError **)error {
    BOOL validationResult = [_inputValidator validateInput:self error:error];
    
    return validationResult;
}

- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSError *error = nil;
    if (!_inputValidator) {
        return YES;
    } else if (self.maxLength != 0 && [[self.text stringByReplacingCharactersInRange:range withString:string] length] > self.maxLength) {
        return NO;
    }
    
    BOOL validationResult = [_inputValidator validateInput:self shouldChangeCharactersInRange:range replacementString:string error:&error];
    
    return validationResult;
}

- (void)didBeginEditing:(NSNotification *)notification {
    if (/* UIGraphicsGetCurrentContext() && */self.selectedEditingImage && [[notification object] isEqual:self])
        [self setBackground: self.selectedEditingImage];
}

- (void)didEndEditing:(NSNotification *)notification {
    if (/* UIGraphicsGetCurrentContext() && */self.normalEditingImage && [[notification object] isEqual:self])
        [self setBackground: self.normalEditingImage];
}

- (void)animationKeyboard:(NSNotification *)notification {
    CGRect keyboardFrameBegin = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIView *superview = [self superview];
    if (keyboardFrameBegin.origin.y == [[UIApplication sharedApplication] keyWindow].frame.size.height) {
        // 在调用这个通知之前，键盘是隐藏的
        superview.mementoFrame = [self superview].frame;
    }
    
    [self reciveFocus:notification];
}

- (void)reciveFocus:(NSNotification *)notification {
    CGRect keyboardFrameEnd = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIView *superview = [self superview];
    if (keyboardFrameEnd.origin.y == [[UIApplication sharedApplication] keyWindow].frame.size.height) {
        // 在调用这个通知之后，键盘是隐藏的
        [self superview].frame = superview.mementoFrame;
    } else if ([superview isKindOfClass:[UITableView class]]) {
        //
    } else if ([superview isKindOfClass:[UIScrollView class]]) {
        //
    } else if ([superview isKindOfClass:[UIView class]]) {
        CGRect currentTextFieldRect = [[[UIApplication sharedApplication] keyWindow] convertRect:self.frame fromView:superview];
        if (CGRectGetMaxY(currentTextFieldRect) < keyboardFrameEnd.origin.y) {
            return;
        }
        
        CGFloat offset = [[UIApplication sharedApplication] keyWindow].frame.size.height - keyboardFrameEnd.size.height - CGRectGetMaxY(currentTextFieldRect);
        CGRect rect = [superview frame];
        rect.origin.y += offset;
        [superview setFrame:rect];
    }
}

- (void)didEndEditing {
    if (_inputValidator) {
        [_inputValidator textFieldDidEndEditing:self];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_inputValidator release];
    [_normalEditingImage release];
    [_selectedEditingImage release];
    [super dealloc];
}

@end
