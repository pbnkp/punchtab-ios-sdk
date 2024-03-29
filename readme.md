#PunchTab iOS SDK

##What is the PunchTab iOS SDK?

The PunchTab iOS SDK enable you to bring your customized loyalty and reward programs to your mobile apps. It is a static library that has been compiled as a "fat" binary for both iOS devices and the iOS Simulator. If you have any issues, please send them to <ios@punchtab.com>.

  
##Integrating the PunchTab SDK into your project  
  
1. Go to <http://www.github.com/PunchTab/punchtab-ios-sdk> and either download the package, or clone the git repository.
2. Include the libPTSDK.a library and the PTController.h header in your project.
3. The SDK uses ASIHTTPRequest, which requires additional frameworks. Go to your project's **Build Phases** and choose **Link Binaries With Libraries** Add these frameworks, along with the **libPTSDK.a**:
	* QuartzCore
	* CFNetwork
	* CoreGraphics
	* libz
	* MobileCoreServices
	* SystemConfiguration
![Frameworks](http://punchtab.github.com/punchtab-ios-sdk/frameworks.jpg)

4. Finally, make sure you have *"-ObjC -all_load"* to your "Other linker flags" in your build settings.
![Frameworks](http://punchtab.github.com/punchtab-ios-sdk/linker.jpg)


##SDK Usage
Before you get started, you'll need to get a Application ID from [punchtab.com](http://www.punchtab.com)

###Simple interface

The **PTController** class is the only interface to the SDK. Import the PTController.h class anywhere you will be needing access to the SDK.

```objc
#import "PTController.h"
```

You can instantiate a PTController anywhere you want, but the UIApplicationDelegate subclass for your app will need access to it.

```objc
	myPTController = [[PTController alloc] initWithAppId:@"123456"];
```
###Shared sign-on

The PunchTab SDK uses Safari in order to authenticate the user. When you call the *login* method, the user will be directed out of the app to Safari. After the user signs in and gives your app permission, the user will be redirected back to your app where you'll get a login response.

If the user has previously logged into PunchTab either by browsing Safari, or through another application that has incorporated the PunchTab SDK, the user will not have to login to PunchTab again, and has only to give your app permission to continue.

For this to work, you'll need to implement this method in your UIApplicationDelegate subclass:

```objc
	- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

	    return [myPTController handleOpenURL:url];
	}
``` 
If you're using other shared or single sign-on SDKs in your app, like the Facebook SDK, you'll already have this method implemented, but will want to modify it to look something like this:

```objc
	- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

    	return ([myPTController handleOpenURL:url] || [myFacebook handleOpenURL:url]);
	}
```

Lastly, in your app's Info.plist, add a key for **URLTypes** and a subItem of that called **URLSchemes**. Add an item with the format *ptsdk&lt;your punchtab Application ID&gt;*. i.e. *ptsdk12345*

![Frameworks](http://punchtab.github.com/punchtab-ios-sdk/plist.jpg)


###Common requests

####Responses, delegates, and notifications
In order to get the responses for your requests, you will have to either implement a delegate or use NSNotifications. Both are supported. The **PTControllerDelegate** protocol has response methods for each respective request. Each request also has a notification string that you can use instead, which are detailed in **PTController.h**. The notification will have the response data in the **userinfo** property.

All responses will NSDictionarys containing an HTTP status code and the response data. You can access them with the appropriate keys in **PTController.h**

####login
This method will go through the single sign-on process detailed above. If a user has already logged in (i.e. has a token), the login will succeed immediately. 

```objc
	[myPTController login];
```

#####Corresponding delegate:

```objc
	- (void)loginFinished:(NSDictionary *)response;
```


####sendActivity: and sendActivity:withPoints:
This method will send one of the PunchTab activities to the server. The latter method lets you set a custom point value. Please see the PunchTab [developer's site](http://www.punchtab.com/developers) for more valid actions.

```objc
	[myPTController sendActivity:@"tweet"];
```

```objc
	[myPTController sendActivity:@"comment" withPoints:200];
```

#####Corresponding delegate:

```objc
	- (void)activityFinished:(NSDictionary *)response;
```


####getRewards
Gets the rewards available to the user. You can optionally set a limit on the number of rewards returned.

```objc
	[myPTController getRewards];
```

```objc
	[myPTController getRewardsLimit:10];
```

#####Corresponding delegate:

```objc
	- (void)rewardsReceived:(NSDictionary *)response;
```

####redeemReward:
Send the "redeem" activity for a given reward_id to the server. Redeeming a reward is an activity, so the same delegate is used as *sendActivity:*

```objc
	[myPTController redeemReward:myRewardId];
```

#####Corresponding delegate:

```objc
	- (void)activityFinished:(NSDictionary *)response;
```

####getLeaderboard:
Gets the leaderboard for your rewards program. you can optionally get the current user's relative position data included.

```objc
	[myPTController getLeaderboard];
```

```objc
	[myPTController getLeaderboardWithMe:YES];
```

#####Corresponding delegate:

```objc
	- (void)leaderboardReceived:(NSDictionary *)response;
``` 


There are more requests available and documented in **PTController.h**

##Third party Package - License - Copyright / Creator
asi-http-request BSD Copyright (c) 2007-2011, All-Seeing Interactive.

SBJSON MIT Copyright (C) 2007-2011 Stig Brautaset.

Reachability BSD Copyright (C) 2011 Donoho Design Group, L.L.C.

Reachability BSD Copyright (C) 2011 Apple Inc.
