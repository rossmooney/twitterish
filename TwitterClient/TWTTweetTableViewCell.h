//
//  TWTTweetTableViewCell.h
//  TwitterClient
//
//  Created by Ross Mooney on 2/4/15.
//  Copyright (c) 2015 rossmooney. All rights reserved.
//

@import UIKit;

@interface TWTTweetTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *tweetMessage;
@property (nonatomic, weak) IBOutlet UILabel *timestamp;
@property (nonatomic, weak) IBOutlet UILabel *user;

@end
