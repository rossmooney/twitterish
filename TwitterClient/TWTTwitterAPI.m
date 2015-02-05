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
#import "TWTAppDelegate.h"
#import "CDUser.h"
#import "CDTweet.h"
#import "CoreData/CoreData.h"

NSString * const kCurrentUserID = @"CurrentUserID";


@implementation TWTTwitterAPI

+ (id)sharedInstance {
    static TWTTwitterAPI *sharedTwitterAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTwitterAPI = [[self alloc] init];
    });
    return sharedTwitterAPI;
}

- (void)setCurrentUserId:(NSString *)currentUserId {
    _currentUserId = currentUserId;
    [[NSUserDefaults standardUserDefaults] setObject:_currentUserId forKey:kCurrentUserID];
}

#pragma mark - API Methods

- (void)signUpWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(NSError *error))completionHandler {
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"CDUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username = %@", username];
    [fetch setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch error:&error];
    if(results) {
        if(results.count > 0) {
            completionHandler([NSError errorWithDomain:@"User already exists." code:0 userInfo:nil]);
        }
        else {
            //User does not exist, create user
            CDUser *user = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"CDUser"
                                   inManagedObjectContext:[self managedObjectContext]];
            user.username = username;
            user.password = password;
            user.userid = [self uuidString];
            self.currentUserId = user.userid;
            
            //Save changes
            NSError *saveError;
            [[self managedObjectContext] save:&saveError];
            completionHandler(saveError);
        }
    }
}

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(NSError *error))completionHandler {
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"CDUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username = %@ AND password = %@", username, password];
    [fetch setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch error:&error];
    if(results) {
        if(results.count > 0) {
            CDUser *user = (CDUser *)results[0];
            self.currentUserId = user.userid;
            completionHandler(nil);
        }
        else {
            completionHandler([NSError errorWithDomain:@"Username and password combination not recognized." code:0 userInfo:nil]);
        }
    } else {
        completionHandler(error);
    }
}

- (void)logoutWithCompletion:(void (^)(void))completionHandler {
    self.currentUserId = nil;
    completionHandler();
}

- (void)requestTweetsWithCompletion:(void (^)(NSArray *tweets))completionHandler {
    
    //Check for saved tweets in core data
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"CDTweet"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid = %@", self.currentUserId];
    [fetch setPredicate:predicate];
    
    NSError *error = nil;

    NSMutableArray *tweetArray = [NSMutableArray array];
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch error:&error];
    if(results) {
        if(results.count > 0) {
            for(CDTweet *cdTweet in results) {
                TWTTweet *tweet = [[TWTTweet alloc] initWithManagedObject:cdTweet];
                [tweetArray addObject:tweet];
            }
        }
    }

    //Sort by date
    NSArray *sortedArray = [tweetArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(TWTTweet*)a timestamp];
        NSDate *second = [(TWTTweet*)b timestamp];
        return [second compare:first];
    }];

    completionHandler(sortedArray);
}

- (void)sendTweetWithMessage:(NSString *)message completion:(void (^)(NSError *error))completionHandler {
    //Create tweet
    CDTweet *tweet = [NSEntityDescription
                    insertNewObjectForEntityForName:@"CDTweet"
                    inManagedObjectContext:[self managedObjectContext]];
    tweet.message = message;
    tweet.timestamp = [NSDate date];
    tweet.userid = self.currentUserId;
    tweet.tweetid = [self uuidString];
    
    //Save changes
    NSError *saveError;
    [[self managedObjectContext] save:&saveError];
    completionHandler(saveError);
}

- (TWTUser *)userForId:(NSString *)userId {
    //Check for saved tweets in core data
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"CDUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid = %@", userId];
    [fetch setPredicate:predicate];
    
    NSError *error = nil;

    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch error:&error];
    if(results && results.count > 0) {
        CDUser *cdUser = (CDUser *)results[0];
        TWTUser *user = [[TWTUser alloc] initWithManagedObject:cdUser];
        return user;
    }
    
    return nil;
}


#pragma mark - Core Data 

- (NSManagedObjectContext *)managedObjectContext {
    TWTAppDelegate *appDelegate = (TWTAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

#pragma mark - Helper Methods

- (NSString *)uuidString {
    // Returns a UUID
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    return uuidString;
}

- (void)clearUsers {
    NSFetchRequest *allUsers = [[NSFetchRequest alloc] init];
    [allUsers setEntity:[NSEntityDescription entityForName:@"CDUser" inManagedObjectContext:[self managedObjectContext]]];
    [allUsers setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * users = [[self managedObjectContext] executeFetchRequest:allUsers error:&error];

    for (NSManagedObject * user in users) {
        [[self managedObjectContext] deleteObject:user];
    }
    NSError *saveError = nil;
    [[self managedObjectContext] save:&saveError];

}

- (void)clearTweets {
    NSFetchRequest *allTweets = [[NSFetchRequest alloc] init];
    [allTweets setEntity:[NSEntityDescription entityForName:@"CDTweet" inManagedObjectContext:[self managedObjectContext]]];
    [allTweets setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * tweets = [[self managedObjectContext] executeFetchRequest:allTweets error:&error];
    
    for (NSManagedObject * tweet in tweets) {
        [[self managedObjectContext] deleteObject:tweet];
    }
    NSError *saveError = nil;
    [[self managedObjectContext] save:&saveError];
}
@end
