Custom Keyboards For iOS
======

Description
-------------------
This plugin for open any native iOS keyboard in cordova app.

There is no way to completely replace original keyboard. :-(
Under hood this plugin just create invisible native input and open keyboard for it. You just get callback when text changed.

Installation
-------
~~~
cordova plugin add https://github.com/bmcool/cordova-custom-keyboard
~~~

Methods
-------

- CustomKeyboard.bind(startedValue, keyboardType, changedCb, finishedCb);

Description.
-------
Our plugin creating invisible textview and you need to call 'change' if you want to correct user input;

Available keyboards:
-------
1 =  UIKeyboardTypeDefault;  
2 =  UIKeyboardTypeASCIICapable;  
3 = UIKeyboardTypeNumbersAndPunctuation;  
4 =  UIKeyboardTypeURL;  
5 =  UIKeyboardTypeNumberPad;  
6 =  UIKeyboardTypePhonePad;  
7 =  UIKeyboardTypeNamePhonePad;  
8 =  UIKeyboardTypeEmailAddress;  
9 =  UIKeyboardTypeDecimalPad;  
10 =  UIKeyboardTypeTwitter;  
11 =  UIKeyboardTypeWebSearch;  


Quick Example
-------------
html
~~~
<ion-input id="decimal" [(ngModel)]="phone"></ion-input>
~~~

ts
~~~
ngAfterViewInit() {
  CustomKeyboard.bind('decimal', this, 'phone', 9);
}
~~~

scss
~~~
.text-input[disabled] {
  opacity: 1;
}
~~~

Supported Platforms
-------------------

- iOS


License
-------------------

MIT
