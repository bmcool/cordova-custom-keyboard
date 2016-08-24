#import <Cordova/CDVPlugin.h>

@interface CDVCustomKeyboard : CDVPlugin {
}
@property (nonatomic, copy) NSString* callbackId;
@property (nonatomic) UIKeyboardType keyboardType;

- (void)bind:(CDVInvokedUrlCommand*)command;

@end
