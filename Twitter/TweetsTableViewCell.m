//
//  TweetsTableViewCell.m
//  Twitter
//
//  Created by Tim Lee on 2015/7/2.
//  Copyright (c) 2015年 Y.CORP.YAHOO.COM\timlee. All rights reserved.
//

#import "TweetsTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@implementation TweetsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.tweetTextLabel.text = _tweet.text;
    self.nameLabel.text = _tweet.user.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.timeLabel.text = [dateFormatter stringFromDate:_tweet.createdAt] ;
    [self.userImage setImageWithURL: [NSURL URLWithString:_tweet.user.profileImageUrl]];
    
    
    if(_tweet.retweeted) {
        [self.retweetBtn setImage:[UIImage imageNamed:@"retweet_on.png"] forState:UIControlStateNormal];
    }
    if(_tweet.favorited) {
        NSLog(@"favorite_on.png");
        [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_on.png"] forState:UIControlStateNormal];
    }
}

- (void)prepareForReuse {
    [self.retweetBtn setImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
}


@end
