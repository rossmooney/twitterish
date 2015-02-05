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

- (NSString *)howLongAgo {
    
    NSString *ago;
    NSInteger longAgoMS = -[self.timestamp timeIntervalSinceNow];
    if(longAgoMS == 0) {
        ago = @"now";
    }
    else if(longAgoMS > 0 && longAgoMS < 60) {
        //seconds
        NSInteger seconds = longAgoMS;
        ago = [NSString stringWithFormat:@"%lds", (long)seconds];
    }
    else if(longAgoMS >= 60 && longAgoMS < 3600) {
        //minutes
        NSInteger minutes = longAgoMS/60;
        ago = [NSString stringWithFormat:@"%ldm", (long)minutes];
    }
    else if(longAgoMS >= 3600 && longAgoMS < 3600*24) {
        //hours
        NSInteger hours = longAgoMS/3600;
        ago = [NSString stringWithFormat:@"%ldh", (long)hours];
    }
    else {
        //days
        NSInteger days = longAgoMS/(3600*24);
        ago = [NSString stringWithFormat:@"%ldd", (long)days];
    }
    
    return ago;
}

@end
