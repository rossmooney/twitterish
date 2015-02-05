//
//  TWTComposeViewController.m
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTComposeViewController.h"
#import "TWTTwitterAPI.h"

@interface TWTComposeViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation TWTComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)sendPressed:(id)sender {
    __weak TWTComposeViewController *blockSelf = self;
    [[TWTTwitterAPI sharedInstance] sendTweetWithMessage:self.textView.text completion:^(NSError *error) {
        if(!error) {
            [blockSelf performSegueWithIdentifier:@"unwindToTweets" sender:self];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (IBAction)cancelPressed:(id)sender {
    [self performSegueWithIdentifier:@"unwindToTweets" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
