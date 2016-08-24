
#import "CDVCustomKeyboard.h"

@interface CDVCustomKeyboard ()<UITextViewDelegate>

@end

@implementation CDVCustomKeyboard

UITextView *hiddenTextView;

- (void)pluginInitialize
{
    if (hiddenTextView == NULL) {
        hiddenTextView = [[UITextView alloc] init];
        hiddenTextView.alpha = 0;
        hiddenTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        hiddenTextView.bounds = CGRectMake(0, 0, 0, 0);
        hiddenTextView.keyboardType = UIKeyboardTypeDecimalPad;
        hiddenTextView.delegate = self;
        [self.viewController.view addSubview:hiddenTextView];
    }
}

-(void) resignKeyBoard:(UIButton *)sender
{
    [hiddenTextView resignFirstResponder];
    [sender removeFromSuperview];
}

- (void)textViewDidChange:(UITextView *)textView {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:hiddenTextView.text];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:hiddenTextView.text];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

- (void)bind:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    
    NSString *startedValue = [command argumentAtIndex:0];
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
    hiddenTextView.text = startedValue;
    [hiddenTextView becomeFirstResponder];
    
    //    UIButton *btn = [[UIButton alloc] initWithFrame:self.viewController.view.frame];
    //    [btn addTarget:self action:@selector(resignKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.viewController.view addSubview:btn];
}

@end
