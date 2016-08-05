//
//  RedditSDK.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright (c) 2016 Orest Savchak. All rights reserved.
//

#import "RSInstance.h"
#import "RSLinksFetcher.h"
#import "RSConfigurationValidator.h"
#import "RSCacheFactory.h"

@interface RSInstance ()

@property (strong, nonatomic) RSLinksFetcher *fetcher;

@end

@implementation RSInstance

+ (instancetype)sharedInstance {
    static RSInstance *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [RSInstance new];
    });
    return instance;
}

- (void)searchForLinksWithConfiguration:(nonnull RSSearchConfiguration *)configuration andCallback:(RSCallback)callback {
    NSError *error = nil;
    if ([RSConfigurationValidator validateConfiguration:configuration withError:&error]) {
        [self.fetcher fetchLinksWithConfiguration:configuration andCallback:callback];
    } else {
        callback(@[], error);
    }
}

- (RSLinksFetcher *)fetcher {
    if (!_fetcher) {
        _fetcher = [RSLinksFetcher fetcherWithCache:[RSCacheFactory runtimeCache]
                                  andNetworkFetcher:[RSLinksNetworkFetcher fetcherWithDefaultConfigurations]];
    }
    return _fetcher;
}

@end
