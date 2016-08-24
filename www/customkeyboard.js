
var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');
   
var CustomKeyboard = function() {
};

//keyboard pattern;
// 1 =  UIKeyboardTypeDefault;              
// 2 =  UIKeyboardTypeASCIICapable;       
// 3 = UIKeyboardTypeNumbersAndPunctuation;
// 4 =  UIKeyboardTypeURL;                 
// 5 =  UIKeyboardTypeNumberPad;      
// 6 =  UIKeyboardTypePhonePad;  
// 7 =  UIKeyboardTypeNamePhonePad;
// 8 =  UIKeyboardTypeEmailAddress; 
// 9 =  UIKeyboardTypeDecimalPad;
// 10 =  UIKeyboardTypeTwitter;
// 11 =  UIKeyboardTypeWebSearch;

CustomKeyboard.bind = function(id, scope, model, keyboard) {
    var target = document.getElementById(id);
    var input = target.getElementsByTagName('input')[0];
    input.disabled = true;
    target.disabled = true;
    input.style.opacity = 1;
    !keyboard && (keyboard = 1);
    var onChange = function(v) {
        scope[model] = v;
        input.value = v;
    }
    var onFinish = function(v) {
        target.blur();
    }
    target.ontouchstart = function() {
        exec(onChange, onFinish, "CustomKeyboard", "bind", [input.value, keyboard]);
    }
};

module.exports = CustomKeyboard;
