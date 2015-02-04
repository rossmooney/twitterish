//
//  TWTTwitterAPI.m
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTTwitterAPI.h"
#import "TWTUser.h"
#import "TWTTweet.h"

@implementation TWTTwitterAPI

+ (id)sharedInstance {
    static TWTTwitterAPI *sharedTwitterAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTwitterAPI = [[self alloc] init];
    });
    return sharedTwitterAPI;
}

#pragma mark - API Methods

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(NSError *error))completionHandler {
    
}

- (void)requestTweetsWithCompletion:(void (^)(NSArray *tweets))completionHandler {
    
    //Check for saved tweets in core data
    
    //Check for new tweets since last saved tweet
    
    //Save new tweets to core data
    
    NSMutableArray *tweetArray = [NSMutableArray array];
    for(int i = 0; i < 100; i++) {
        TWTTweet *tweet = [TWTTweet new];
        tweet.tweetMessage = [NSString stringWithFormat:@"This is tweet message number %d" , i];
        tweet.userId = @"1";
        tweet.tweetId = @"0";
        tweet.timestamp = [NSDate date];
        [tweetArray addObject:tweet];
    }
    
    NSArray *tweets = [NSArray arrayWithArray:tweetArray];
    completionHandler(tweets);
}

- (void)sendTweetWithMessage:(NSString *)message completion:(void (^)(NSError *error))completionHandler {
    
}

- (TWTUser *)userForId:(NSString *)userId {
    TWTUser *user = [TWTUser new];
    user.username = @"Ross Mooney";
    user.userId = userId;
    user.password = @"12345";
    
    return user;
}

@end
