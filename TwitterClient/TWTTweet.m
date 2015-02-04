//
//  TWTTweet.m
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTTweet.h"
#import "CDTweet.h"

@implementation TWTTweet

- (id)initWithManagedObject:(CDTweet *)managedObject {
    self = [super init];
    if(self) {
        self.tweetId = managedObject.tweetid;
        self.userId = managedObject.userid;
        self.tweetMessage = managedObject.message;
        self.timestamp = managedObject.timestamp;
    }
    return self;
}

@end
