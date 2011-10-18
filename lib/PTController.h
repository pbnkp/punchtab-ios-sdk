//
//  PTController.h
//  PTSDK
//
//  Copyright 2011 PunchTab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Notifications for using the Notification/Observer pattern
#define kPTLoginNotification @"PT_LOGIN_NOTIFICATION"
#define kPTLogoutNotification @"PT_LOGOUT_NOTIFICATION"
#define kPTLeaderboardResponseNotification @"PT_LEADERBOARD_RESPONSE_NOTIFICATION"
#define kPTUserDataResponseNotification @"PT_USER_DATA_RESPONSE_NOTIFICATION"
#define kPTSendActivityResponseNotification @"PT_SEND_ACTIVITY_RESPONSE_NOTIFICATION"
#define kPTGetActivitiesResponseNotification @"PT_GET_ACTIVITIES_RESPONSE_NOTIFICATION"
#define kPTGetRewardsResponseNotification @"PT_GET_REWARDS_RESPONSE_NOTIFICATION"

//Keys for response objects
#define kPTResponseObject @"PTResponseObject"
#define kPTResponseStatusCode @"PTResponseStatusCode"
#define kPTResponseErrorString @"PTResponseErrorString"
#define kPTTokenKey @"PTTokenKey"

@protocol PTControllerDelegate <NSObject>

@optional

- (void)loginFinished:(NSDictionary *)response;
- (void)logoutFinished:(NSDictionary *)response;
- (void)receivedLeaderboard:(NSDictionary *)response;
- (void)receivedActivities:(NSDictionary *)response;
- (void)receivedRewards:(NSDictionary *)response;
- (void)activityFinished:(NSDictionary *)response;
- (void)receivedUserData:(NSDictionary *)response;

@end

@interface PTController : NSObject {
    
}

@property (nonatomic, retain) NSString * appId;
@property (nonatomic, retain) NSString * ptToken;
@property (nonatomic, retain) NSDictionary * userData;
@property (nonatomic, assign) id <PTControllerDelegate> delegate;

/**
 @returns whether or not there is already a valid token stored
*/
@property (readonly) BOOL hasToken;

/**
 Handler for the single sign-on processing
 @param url - the url of the redirect
 @returns whether or not the method handled the url
*/
- (BOOL)handleOpenURL:(NSURL *)url;

/**
 Only valid contructor
 @param appId - identifier received from punchtab.com
 @returns instance of PTController
*/
- (id)initWithAppId:(NSString *)appId;

/**
 Logs the user in. If there is an existing token, it is used and the response is immediately returned. If not the user is sent throught the single sign-on process.
 @delegate loginFinished:
 @notification kPTLoginNotification
*/
- (void)login;

/**
 Logs the user out. Clears out all local PunchTab related data.
 @delegate logoutFinished:
 @notification kPTLogoutNotification
*/
- (void)logout;

/**
 Gets the leaderboard for the reward program.
 @delegate receivedLeaderboard:
 @notification kPTLeaderboardResponseNotification
 */
- (void)getLeaderboard;

/**
 Gets the leaderboard for the reward program.
 @param showUser - whether or not the user should see their relative placement in the leaderboard
 @delegate receivedLeaderboard:
 @notification kPTLeaderboardResponseNotification
*/
- (void)getLeaderboardWithMe:(BOOL)showUser;

/**
 Gets the user's PunchTab related activity stream
 @delegate receivedActivities:
 @notification kPTGetActivitiesResponseNotification
*/
- (void)getActivities;

/**
 Gets the user's PunchTab related activity stream
 @param limit - the max activities returned
 @delegate receivedActivities:
 @notification kPTGetActivitiesResponseNotification
*/
- (void)getActivitiesLimit:(int)limit;

/**
 Gets the list of rewards available to the user
 @delegate receivedRewards:
 @notification kPTGetRewardsResponseNotification
*/
- (void)getRewards;

/**
 Gets the list of rewards available to the user
 @param limit - the max rewards returned
 @delegate receivedRewards:
 @notification kPTGetRewardsResponseNotification
*/
- (void)getRewardsLimit:(int)limit;

/**
 Send an activity to the server to score points. Default is 100 points.
 @delegate activityFinished:
 @notification kPTSendActivityResponseNotification
*/
- (void)sendActivity:(NSString *)activity;

/**
 Send an activity to the server to score points. Default is 100 points.
 @param points - the number of points to score
 @delegate activityFinished:
 @notification kPTSendActivityResponseNotification
*/
- (void)sendActivity:(NSString *)activity withPoints:(int)points;

/**
 Send an activity to the server. This is more of a direct interface to the API.
 @param parameters - custom parameters sent to the server
 @delegate activityFinished:
 @notification kPTSendActivityResponseNotification
 */
- (void)sendActivity:(NSString *)activity parameters:(NSDictionary *)parameters;

/**
 Forces a call to the server to update the local userData. Use the userData property in order to access local userData.
 @delegate receivedUserData:
 @notification kPTUserDataResponseNotification
 */
- (void)getUserData;

/**
 Send a the redeem activity to the server with a reward id.
 @param rewardId - the id to redeem from the getRewards method
 @delegate activityFinished:
 @notification kPTSendActivityResponseNotification
 */
- (void)redeemReward:(NSNumber *)rewardId;

@end

