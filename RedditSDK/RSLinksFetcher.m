//
//  RSLinksFetcher.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSLinksFetcher.h"
#import "RSLinksNetworkFetcher.h"

@interface RSLinksFetcher ()


@property (strong, nonatomic) RSLinksNetworkFetcher *networkFetcher;
@property (strong, nonatomic) id<RSLinksCache> cache;
@end

@implementation RSLinksFetcher

+ (instancetype)fetcherWithCache:(id<RSLinksCache>)cache andNetworkFetcher:(RSLinksNetworkFetcher *)networkFetcher {
    return [[self alloc] initWithCache:cache andNetworkFetcher:networkFetcher];
}

- (instancetype)initWithCache:(id<RSLinksCache>)cache andNetworkFetcher:(RSLinksNetworkFetcher *)networkFetcher {
    if (self = [super init]) {
        _cache = cache;
        _networkFetcher = networkFetcher;
    }
    return self;
}

- (void)fetchLinksWithConfiguration:(RSSearchConfiguration *)configuration andCallback:(RSCallback)callback {
    __weak RSLinksFetcher *weakSelf = self;
    
    if (configuration.isTopItemsOnly) {
        [self fetchFromAPIWithConfiguration:configuration andCallback:callback];
        return;
    }
    [self.cache getCachedLinksForConfiguration:configuration withCallback:^(NSArray<RSLink *> *cached) {
        if (cached.count > 0) {
            callback(cached, nil);
        } else {
            [weakSelf fetchFromAPIWithConfiguration:configuration andCallback:callback];
        }
    }];
}

- (void)fetchFromAPIWithConfiguration:(RSSearchConfiguration *)configuration andCallback:(RSCallback)callback {
    __weak RSLinksFetcher *weakSelf = self;
    
    [self getConfigurationWithAdditionals:configuration withCallback:^(RSSearchConfiguration *configuration) {
        [self.networkFetcher fetchLinksWithConfiguration:configuration
                                             andCallback:^(NSArray<RSLink *> *links, NSError *error) {
                                                 if (links) {
                                                     [weakSelf.cache cacheLinks:links forConfiguration:configuration];
                                                 }
                                                 callback(links, error);
                                             }];
    }];
}

- (void)getConfigurationWithAdditionals:(RSSearchConfiguration *)configuration
                           withCallback:(void (^)(RSSearchConfiguration *configuration))callback{
    [self.cache getFirstAndLastForConfiguration:configuration withCallback:^(NSArray<RSLink *> *cached) {
        RSSearchConfiguration *newConfiguration = [RSSearchConfiguration configurationWithBlock:^(RSConfigurationBuilder *builder) {
            builder.batchNumber = configuration.batchNumber;
            builder.limit = configuration.limit;
            builder.query = configuration.query;
        }];
        if (configuration.isTopItemsOnly) {
            newConfiguration.before = [cached.firstObject fullName];
        } else {
            newConfiguration.after = [cached.lastObject fullName];
        }

        callback(newConfiguration);
    }];
}


@end
