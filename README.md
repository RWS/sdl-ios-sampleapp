SDL iOS SDK Sample App
======================

This is a guide that helps you get started with the SDL iOS SDK so that you can add Translation capabilities to your iOS app. 
This guide includes a short tutorial of a sample app that makes use of the SDK.

### Adding the SDK to your app in 3 Easy Steps

#### STEP 1. Get Your SDL Language Cloud API Key

- [Sign Up Here] (https://languagecloud.sdl.com/translation-api/sign-up) to get a Free API Key

#### STEP 2. Install the SDK

- The SDK is available as a cocoapod and can be installed as follows:
 
```ruby
platform :ios, '7.0'
pod "SDL-iOS-SDK", "~> 0.1.0"
```

#### STEP 3. Import the SDK in your code

```ruby
#import "SDL.h"
```

### Using the SDL Translation API

#### Setup your API Key once

```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[SDL languageCloud] setup:@"<your api key>"]
   ...
}
```

#### Performing a text translation

```ruby
 [[SDL languageCloud] translateText:@"Good Morning" from:[NSLocale localeWithLocaleIdentifier:@"en"] to:[NSLocale localeWithLocaleIdentifier:@"fr"] success:^(NSString* translation)
    {
        NSLog(@"Successful Translation: %@", translation);
    }
    failure:^(NSString* errorMessage)
    {
        NSLog(@"Error: %@", errorMessage);
    }
];
```
### Sample App Tutorial

#### Download and open the project

- [Download the project] (https://github.com/dancali/sdl-ios-sampleapp/archive/master.zip) as a ZIP file
- Open the SDL-iOS-SampleApp.xcworkspace XCode Workspace file
- You should now see the project loaded in XCode:
<p align="center" >
  <img src="https://raw.githubusercontent.com/sdl/sdl-ios-sampleapp/master/resources/project.png" alt="SDL" title="SDL">
</p>

#### Setup your API key

- If you run the project you should immediately get an error:
<p align="center" >
  <img src="https://raw.githubusercontent.com/sdl/sdl-ios-sampleapp/master/resources/setup.png" alt="SDL" title="SDL">
</p>
- Remove error line:
```ruby
    #error @"Setup your SDL Language Cloud API Key"
```
- And enter your valid API key:
```ruby
    [[SDL languageCloud] setup:@"<Insert Your SDL Language Cloud API Key Here>"];
```
- Then run the project again
- Everything should build perfectly and the simulator should launch

### License

The SDL iOS SDK is made available under the MIT license. Pleace see the LICENSE file 
for more details.

