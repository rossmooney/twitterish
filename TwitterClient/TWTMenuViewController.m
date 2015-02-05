//
//  TWTMenuViewController.m
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTMenuViewController.h"
#import "TWTTwitterAPI.h"
#import "TWTUser.h"

@interface TWTMenuViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel     *loggedInAsLabel;
@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UIButton    *loginButton;
@property (nonatomic, weak) IBOutlet UIButton    *logoutButton;
@property (nonatomic, weak) IBOutlet UIButton    *cancelButton;
@property (nonatomic, weak) IBOutlet UIButton    *signUpButton;

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

- (void)viewWillAppear:(BOOL)animated {
    if([[TWTTwitterAPI sharedInstance] currentUserId]) {
        [self showLogoutInterface];
    }
    else {
        [self showLoginInterface];
    }
}

- (void)showLoginInterface {
    self.loginButton.hidden = self.signUpButton.hidden = self.usernameField.hidden = self.passwordField.hidden = NO;
    self.logoutButton.hidden = self.cancelButton.hidden = self.loggedInAsLabel.hidden = YES;
}

- (void)showLogoutInterface {
    self.loginButton.hidden = self.signUpButton.hidden = self.usernameField.hidden = self.passwordField.hidden = YES;
    self.logoutButton.hidden = self.cancelButton.hidden = NO;
    NSString *currentUserId = [[TWTTwitterAPI sharedInstance] currentUserId];
    TWTUser *user = ((TWTUser *)[[TWTTwitterAPI sharedInstance] userForId:currentUserId]);
    self.loggedInAsLabel.text = [NSString stringWithFormat:@"Logged in as %@", user.username];
}

#pragma mark - IBActions

- (IBAction)loginPressed:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [[TWTTwitterAPI sharedInstance] loginWithUsername:username andPassword:password completion:^(NSError *error) {
        if(!error) {
            //Logged in successful, show tweets
            [self performSegueWithIdentifier:@"showTweets" sender:self];
        }
        else {
            //display error
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (IBAction)signUpPressed:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [[TWTTwitterAPI sharedInstance] signUpWithUsername:username andPassword:password completion:^(NSError *error) {
        if(!error) {
            //Sign up successful, show tweets
            [self performSegueWithIdentifier:@"showTweets" sender:self];
        }
        else {
            //display error
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (IBAction)logoutPressed:(id)sender {
    [[TWTTwitterAPI sharedInstance] logoutWithCompletion:^{
        [self showLoginInterface];
    }];
}

- (IBAction)cancelPressed:(id)sender {
    //Return To Tweets
    [self performSegueWithIdentifier:@"showTweets" sender:self];
}

#pragma mark - UITextViewDelegate

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
