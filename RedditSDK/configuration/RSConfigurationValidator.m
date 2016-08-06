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
        return [self setError:@"Limit should be (0, 100)" withErrorRef:error];
    }
    if (configuration.batchNumber < -1) {
        return [self setError:@"batch number should be equal or greater then 0 or be equal to constant RSBatchNumberTopItems" withErrorRef:error];
    }
    if (configuration.query.length == 0) {
        return [self setError:@"Query should not be empty" withErrorRef:error];
    }
    
    return YES;
}

+ (BOOL)setError:(NSString *)error withErrorRef:(NSError **)errorRef {
    if (errorRef) {
        *errorRef = [NSError errorWithDomain:@"configuration" code:-1 userInfo:@{@"error":error}];
    }
    return NO;
}

@end
