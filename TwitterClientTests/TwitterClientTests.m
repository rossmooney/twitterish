//
//  TwitterClientTests.m
//  TwitterClientTests
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTTwitterAPI.h"
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface TwitterClientTests : XCTestCase

@end

@implementation TwitterClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSignUp {
    [[TWTTwitterAPI sharedInstance] clearUsers];
    [[TWTTwitterAPI sharedInstance] clearTweets];
    
    NSString *testUser = @"testUser";
    NSString *testPassword = @"testPassword";
    
    [[TWTTwitterAPI sharedInstance] signUpWithUsername:testUser andPassword:testPassword completion:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

- (void)testLogout {
    [[TWTTwitterAPI sharedInstance] logoutWithCompletion:^{
        XCTAssertNil([[TWTTwitterAPI sharedInstance] currentUserId]);
    }];
}

- (void)testLogin {
    NSString *testUser = @"testUser";
    NSString *testPassword = @"testPassword";
    
    [[TWTTwitterAPI sharedInstance] loginWithUsername:testUser andPassword:testPassword completion:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

- (void)testComposeTweet {
    NSString *testMessage = @"This is a test message";
    
    [[TWTTwitterAPI sharedInstance] sendTweetWithMessage:testMessage completion:^(NSError *error) {
        [[TWTTwitterAPI sharedInstance] requestTweetsWithCompletion:^(NSArray *tweets) {
            XCTAssertEqual(tweets.count, 1);
        }];
    }];
}

@end
