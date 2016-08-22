#import "CDVCustomKeyboard.h"

@implementation UIView (FindFirstResponder)
- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}
@end


@interface CDVCustomKeyboard ()<UITextViewDelegate> {
    BOOL isBlockHtmlKeyboard;
    NSString *elementId;
}

@property (nonatomic, readwrite, assign) BOOL keyboardIsVisible;

@end

@implementation CDVCustomKeyboard

UITextView *hiddenTextView;

- (void)pluginInitialize
{
    if (hiddenTextView == NULL) {
        isBlockHtmlKeyboard = NO;
        hiddenTextView = [[UITextView alloc] init];
        hiddenTextView.alpha = 0;
        hiddenTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        hiddenTextView.bounds = CGRectMake(0, 0, 0, 0);
        hiddenTextView.keyboardType = UIKeyboardTypeDecimalPad;
        hiddenTextView.delegate = self;
        [self.viewController.view addSubview:hiddenTextView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (!isBlockHtmlKeyboard) {
        return;
    }
    
    UIView * v = [self.webView findFirstResponder];
    
    if (v) {
        [(UIWebView *)self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').keyboard = document.activeElement;", elementId]];
        
        hiddenTextView.text = [(UIWebView *)self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').keyboard.value;", elementId]];
        [hiddenTextView becomeFirstResponder];
        UIButton *btn = [[UIButton alloc] initWithFrame:self.viewController.view.frame];
        [btn addTarget:self action:@selector(resignKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewController.view addSubview:btn];
    }
}

-(void) resignKeyBoard:(UIButton *)sender
{
    [hiddenTextView resignFirstResponder];
    [sender removeFromSuperview];
    isBlockHtmlKeyboard = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    [(UIWebView *)self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').keyboard.value = '%@';", elementId, hiddenTextView.text]];
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textViewDidEndEditing");
}

- (void)open:(CDVInvokedUrlCommand*)command
{
    UIView * v = [self.webView findFirstResponder];
    
    if (v) {
        NSLog(@"WEB Keyboard is too fast..so resignFirstResponder");
        [v resignFirstResponder];
    }
    
    isBlockHtmlKeyboard = YES;
    
    elementId = [command argumentAtIndex:0];
    NSInteger keyBoardTypeInt = [[command argumentAtIndex:1] integerValue];
    
    switch (keyBoardTypeInt) {
        case 1:
            self.keyboardType =  UIKeyboardTypeDefault;
            break;
        case 2:
            self.keyboardType =  UIKeyboardTypeASCIICapable;
            break;
        case 3:
            self.keyboardType =  UIKeyboardTypeNumbersAndPunctuation;
            break;
        case 4:
            self.keyboardType =  UIKeyboardTypeURL;
            break;
        case 5:
            self.keyboardType =  UIKeyboardTypeNumberPad;
            break;
        case 6:
            self.keyboardType =  UIKeyboardTypePhonePad;
            break;
        case 7:
            self.keyboardType =  UIKeyboardTypeNamePhonePad;
            break;
        case 8:
            self.keyboardType =  UIKeyboardTypeEmailAddress;
            break;
        case 9:
            self.keyboardType =  UIKeyboardTypeDecimalPad;
            break;
        case 10:
            self.keyboardType =  UIKeyboardTypeTwitter;
            break;
        case 11:
            self.keyboardType =  UIKeyboardTypeWebSearch;
            break;
        default:
            self.keyboardType =  keyBoardTypeInt;
            break;
    }
    hiddenTextView.keyboardType = self.keyboardType;
}

@end
