//
//  SDLSampleApp.m
//
//
// Copyright (c) 2013 SDL plc. (http://languagecloud.sdl.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SDLSampleApp.h"
#import "SDL.h"

@interface SDLSampleApp()
{
    UIActivityIndicatorView* _spinner;
}
@end

@implementation SDLSampleApp

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    #error @"Setup your SDL Language Cloud API Key"
    // Sign up for a Free API Key here: https://languagecloud.sdl.com/translation-api/sign-up?_ref=sdl-ios-sdk
    [[SDL languageCloud] setup:@"<Insert Your SDL Language Cloud API Key Here>"];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Prepare the spinner
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_spinner hidesWhenStopped];
    _spinner.center = CGPointMake(self.window.frame.size.width / 2, self.window.frame.size.height / 2);
    [self.window addSubview:_spinner];
    
    // Let's try to translate something
    [self promptForInput];
    
    return YES;
}

- (void) promptForInput
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter a sentence in English"  message:nil
                                            delegate:self
                                            cancelButtonTitle:@"Translate to French"
                                            otherButtonTitles: nil];
    
    message.alertViewStyle = UIAlertViewStylePlainTextInput;
    message.tag = 10;
    message.delegate = self;
    UITextField* answerField = [message textFieldAtIndex:0];
    answerField.keyboardType = UIKeyboardTypeASCIICapable;
    answerField.placeholder = @"Hello world";
    [message show];
}

- (void) showTranslation: (NSString*) text
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:text
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Perform another translation"
                                            otherButtonTitles: nil];
    message.tag = 20;
    [message show];
}

- (void) performTranslation: (NSString*) text
{
    // Show some progress
    [_spinner startAnimating];
    
    [[SDL languageCloud] translateText:text from:[NSLocale localeWithLocaleIdentifier:@"en"] to:[NSLocale localeWithLocaleIdentifier:@"fr"] success:^(NSString* translation)
     {
         // Stop the progress first
         [_spinner stopAnimating];

         // Great, we got something, let's show it
         [self showTranslation:translation];
     }
     failure:^(NSString* errorMessage)
     {
         // Stop the progress first
         [_spinner stopAnimating];

         // Something went wrong, let's show the user what happened
         [self showTranslation:[NSString stringWithFormat:@"Error: %@", errorMessage]];
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 20)
    {
        // Let's perform another translation
        [self promptForInput];
        return;
    }
    
    // The user just requested a translation
    UITextField *textField = [alertView textFieldAtIndex:0];
    NSString* text = [textField text];
    
    if ([text length] == 0)
    {
        // The text to be translated is empty so let's start again
        [self promptForInput];
        return;
    }

    // Alright we got some text, let's try to translate it
    [self performTranslation:text];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
