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
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(NSError *error))completionHandler;
- (void)requestTweetsWithCompletion:(void (^)(NSArray *tweets))completionHandler;
- (void)sendTweetWithMessage:(NSString *)message completion:(void (^)(NSError *error))completionHandler;
- (TWTUser *)userForId:(NSString *)userId;

@end
