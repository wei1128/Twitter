//
//  TweetsViewController.m
//  Twitter
//
//  Created by Tim Lee on 2015/7/2.
//  Copyright (c) 2015年 Y.CORP.YAHOO.COM\timlee. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "LoginViewController.h"
#import "TweetsTableViewCell.h"
#import "NewTweetViewController.h"
#import "TweetDetailsViewController.h"



@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TweetsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetsTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"TweetsTableViewCell"];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationItem.title = @"Home";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
    [self setupRefreshControl];
    [self updateTimeline];
    
//    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
//        for (Tweet *tweet in tweets){ 
//            NSLog(@"text: %@", tweet.text);
//        }
//    }];
}

- (void) setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(updateTimeline)
             forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull To Refresh"];
    
    self.refreshControl = refreshControl;
    [self.tableView insertSubview:refreshControl atIndex:0];
    
}

- (void) updateTimeline {
    
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        NSLog(@"%@", tweets);
        [self.refreshControl endRefreshing];
        
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
    
}

- (void) onNewTweet {
    NewTweetViewController *vc = [[NewTweetViewController alloc
                                   ] init];
    
    vc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogout:(id)sender {
    [User logout];
}

- (void)logout {
    [User logout];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - table view

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetsTableViewCell" forIndexPath:indexPath];
    cell.tweet = self.tweets[indexPath.row];
    
//    cell.tweetTextLabel.text = cell.tweet.text;
//    cell.nameLabel.text = cell.tweet.user.name;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
//    cell.timeLabel.text = [dateFormatter stringFromDate:cell.tweet.createdAt] ;
//    [cell.userImage setImageWithURL: [NSURL URLWithString:cell.tweet.user.profileImageUrl]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    vc.tweet = self.tweets[indexPath.row];
    
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
