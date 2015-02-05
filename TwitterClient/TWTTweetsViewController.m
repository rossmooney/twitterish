//
//  ViewController.m
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

#import "TWTTweetsViewController.h"
#import "TWTTweetTableViewCell.h"
#import "TWTTwitterAPI.h"
#import "TWTTweet.h"
#import "TWTUser.h"

@interface TWTTweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak)     IBOutlet UITableView    *tableView;
@property (nonatomic, strong)            NSArray        *tweets;

@end

@implementation TWTTweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateTweets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)menuPressed:(id)sender {
    [self performSegueWithIdentifier:@"showMenu" sender:self];
}

- (IBAction)composePressed:(id)sender {
    [self performSegueWithIdentifier:@"showCompose" sender:self];
}

#pragma mark - Twitter API Methods

- (void)updateTweets {
    __block TWTTweetsViewController *blockSelf = self;
    [[TWTTwitterAPI sharedInstance] requestTweetsWithCompletion:^(NSArray *tweets) {
        blockSelf.tweets = tweets;
        [blockSelf.tableView reloadData];
    }];
}

#pragma mark - Table View DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TWTTweetTableViewCell *cell = (TWTTweetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TWTTweetTableViewCell" forIndexPath:indexPath];
    
    TWTTweet *tweet = self.tweets[indexPath.row];
    cell.tweetMessage.text = tweet.tweetMessage;
    cell.timestamp.text = [tweet howLongAgo];

    TWTUser *user = [[TWTTwitterAPI sharedInstance] userForId:tweet.userId];
    cell.user.text = user.username;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Determine height based on tweet message size
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Tapped a tweet
}
@end
