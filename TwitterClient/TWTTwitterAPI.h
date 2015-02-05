//
//  TWTTwitterAPI.h
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TWTUser;

@interface TWTTwitterAPI : NSObject

@property (nonatomic, copy) NSString *currentUserId;

//Singleton
+ (id)sharedInstance;

//API Methods

//Login/Signup
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(NSError *error))completionHandler;
- (void)signUpWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(NSError *error))completionHandler;
- (void)logoutWithCompletion:(void (^)(void))completionHandler;

//Tweets
- (void)requestTweetsWithCompletion:(void (^)(NSArray *tweets))completionHandler;
- (void)sendTweetWithMessage:(NSString *)message completion:(void (^)(NSError *error))completionHandler;

//Users
- (TWTUser *)userForId:(NSString *)userId;

@end
