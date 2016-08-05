//
//  RSRedditURLProvider.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSRedditURLProvider.h"

@interface RSRedditURLProvider ()

@property (strong, nonatomic) NSURL *baseURL;

@end

@implementation RSRedditURLProvider

static NSString *const RSRedditBaseURL = @"www.reddit.com";

static NSString *const RSSearchPath = @"/search";

static NSString *const RSJSONExtension = @".json";

- (NSURL *)searchLinksURLWithConfiguration:(RSSearchConfiguration *)configuration {
    NSURLComponents *urlComponents = [NSURLComponents new];
    
    [urlComponents setScheme:@"https"];
    [urlComponents setHost:RSRedditBaseURL];
    [urlComponents setPath:[NSString stringWithFormat:@"%@/%@", RSSearchPath, RSJSONExtension]];
    [urlComponents setQuery:[self queryStringFromConfiguration:configuration]];
    
    return [urlComponents URL];
}

- (NSURL *)baseURL {
    if (!_baseURL) {
        _baseURL = [NSURL URLWithString:RSRedditBaseURL];
    }
    return _baseURL;
}

- (NSString *)queryStringFromConfiguration:(RSSearchConfiguration *)configuration {
    NSMutableString *query = [NSMutableString stringWithFormat:@"%@=%@", @"query", configuration.query];
    if (configuration.limit != 0) {
        [query appendString:[NSString stringWithFormat:@"&%@=%ld", @"limit", configuration.limit]];
    }
    if (configuration.after.length > 0) {
        [query appendString:[NSString stringWithFormat:@"&%@=%@", @"after", configuration.after]];
    } else if (configuration.before.length > 0) {
        [query appendString:[NSString stringWithFormat:@"&%@=%@", @"before", configuration.before]];
    }
    return [NSString stringWithString:query];
}

@end
