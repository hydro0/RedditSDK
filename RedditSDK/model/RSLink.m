//
//  RSLink.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSLink.h"

@implementation RSLink

static NSString *const RSRedditLinkPrefix = @"t3";

+ (instancetype)linkWithDictionary:(NSDictionary *)dictionary {
    return [[RSLink alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _idx = dictionary[@"id"];
        _title = dictionary[@"title"];
        _createdAt = dictionary[@"created"] ? [NSDate dateWithTimeIntervalSince1970:[dictionary[@"created"] longValue]] : nil;
        _thumbnailURL = dictionary[@"thumbnail"];
    }
    return self;
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@_%@", RSRedditLinkPrefix, self.idx];
}

@end
