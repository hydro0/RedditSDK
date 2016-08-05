//
//  RSSearchConfiguration.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSSearchConfiguration.h"

@implementation RSSearchConfiguration

+ (instancetype)configurationWithBlock:(RSConfigurationBuilderBlock)block {
    RSConfigurationBuilder *builder = [RSConfigurationBuilder new];
    block(builder);
    return [builder build];
}

- (instancetype)initWithBuilder:(RSConfigurationBuilder *)builder {
    if (self = [super init]) {
        _query = builder.query;
        _limit = builder.limit;
        _batchNumber = builder.batchNumber;
    }
    return self;
}

- (BOOL)isTopItemsOnly {
    return self.batchNumber == RSBatchNumberTopItems;
}

@end

@implementation RSConfigurationBuilder

- (RSSearchConfiguration *)build {
    return [[RSSearchConfiguration alloc] initWithBuilder:self];
}

@end
