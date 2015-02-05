//
//  TWTMenuViewController.m
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTMenuViewController.h"
#import "TWTTwitterAPI.h"

@interface TWTMenuViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;


@end

@implementation TWTMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)loginPressed:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [[TWTTwitterAPI sharedInstance] loginWithUsername:username andPassword:password completion:^(NSError *error) {
        if(!error) {
            //Logged in successful, show tweets
        }
        else {
            //display error
        }
    }];
}

- (IBAction)signUpPressed:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [[TWTTwitterAPI sharedInstance] signUpWithUsername:username andPassword:password completion:^(NSError *error) {
        if(!error) {
            //Sign up successful, show tweets
        }
        else {
            //display error
        }
    }];
}

#pragma mark - UITextViewDelegate

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}
@end
