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

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testMenu {
    [self signUp];
    
    [self login];
}

- (void)signUp {
    NSString *testUser = @"testUser";
    NSString *testPassword = @"testPassword";
    
    [[TWTTwitterAPI sharedInstance] signUpWithUsername:testUser andPassword:testPassword completion:^(NSError *error) {
        if(error) {
            XCTAssert(NO, @"Fail");
        }
        else {
            XCTAssert(YES, @"Pass");
        }
    }];
}

- (void)login {
    NSString *testUser = @"testUser";
    NSString *testPassword = @"testPassword";
    
    [[TWTTwitterAPI sharedInstance] signUpWithUsername:testUser andPassword:testPassword completion:^(NSError *error) {
        if(error) {
            XCTAssert(NO, @"Fail");
        }
        else {
            XCTAssert(YES, @"Pass");
        }
    }];
}

@end
