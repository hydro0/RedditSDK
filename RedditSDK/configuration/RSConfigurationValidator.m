//
//  RSConfigurationValidator.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSConfigurationValidator.h"

@implementation RSConfigurationValidator

+ (BOOL)validateConfiguration:(RSSearchConfiguration *)configuration withError:(NSError **)error {
    if (configuration.limit > 100 || configuration.limit < 0) {
        *error = [NSError errorWithDomain:@"configuration" code:-1 userInfo:@{@"error":@"Limit should be (0, 100)"}];
        return NO;
    }
    if (configuration.batchNumber < -1) {
        *error = [NSError errorWithDomain:@"configuration" code:-1 userInfo:@{@"error":@"batch number should be equal or greater then 0 or be equal to constant RSBatchNumberTopItems"}];
        return NO;
    }
    if (configuration.query.length == 0) {
        *error = [NSError errorWithDomain:@"configuration" code:-1 userInfo:@{@"error":@"Query should not be empty"}];
        return NO;
    }
    return YES;
}

@end
