//
//  CDTweet.h
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDTweet : NSManagedObject

@property (nonatomic, retain) NSString * tweetid;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSDate * timestamp;

@end
