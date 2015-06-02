#import "CustomTextView.h"

@interface CustomTextView()

@property(nonatomic, retain) UILabel *placeholderLabel;

@property(nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end


@implementation CustomTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_placeholderLabel release];
    [_placeholderColor release];
    [_placeholder release];
    [super dealloc];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    if( (self = [super initWithFrame:frame]) ) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification {
    if([[self placeholder] length] == 0) {
        return;
    }
    
    if([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1];
    } else {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect {
    if( [[self placeholder] length] > 0 ) {
        if (self.placeholderLabel == nil ) {
            self.placeholderLabel = [[[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)] autorelease];
            self.placeholderLabel.numberOfLines = 0;
            self.placeholderLabel.font = self.font;
            self.placeholderLabel.backgroundColor = [UIColor clearColor];
            self.placeholderLabel.textColor = self.placeholderColor;
            self.placeholderLabel.alpha = 0;
            self.placeholderLabel.tag = 999;
            [self addSubview:self.placeholderLabel];
        }
        self.placeholderLabel.text = self.placeholder;
        [self.placeholderLabel sizeToFit];
        [self sendSubviewToBack:self.placeholderLabel];
    }
    
    if([[self text] length] == 0 && [[self placeholder] length] > 0) {
        [[self viewWithTag:999] setAlpha:1];
    }
    [super drawRect:rect];
}

@end
