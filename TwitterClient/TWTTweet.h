//
//  TWTTweet.h
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWTTweet : NSObject

@property (nonatomic, copy)     NSString *tweetId;
@property (nonatomic, copy)     NSString *userId;
@property (nonatomic, copy)     NSString *tweetMessage;
@property (nonatomic, strong)   NSDate   *timestamp;

@end
