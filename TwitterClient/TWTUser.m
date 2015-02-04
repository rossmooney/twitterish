//
//  TWTUser.m
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTUser.h"
#import "CDUser.h"

@implementation TWTUser

- (id)initWithManagedObject:(CDUser *)managedObject {
    self = [super init];
    if(self) {
        self.userId = managedObject.userid;
        self.username = managedObject.username;
        self.password = managedObject.password;
    }
    return self;
}

@end
