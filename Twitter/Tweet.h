//
//  Tweet.h
//  Twitter
//
//  Created by Tim Lee on 2015/7/1.
//  Copyright (c) 2015年 Y.CORP.YAHOO.COM\timlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSData *createdAt;
@property (nonatomic, strong) User *user;

- (id) initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *) tweetsWithArray:(NSArray *)array;

@property (nonatomic, strong) NSString *tweetID;
@property (nonatomic, strong) NSNumber *retweetCount;
@property (nonatomic, strong) NSNumber *favoriteCount;
@property BOOL retweeted;
@property BOOL favorited;


@end
