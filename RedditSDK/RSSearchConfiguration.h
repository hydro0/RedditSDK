//
//  RSSearchConfiguration.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSLink.h"
@class RSConfigurationBuilder;

static NSInteger const RSBatchNumberTopItems = -1;

typedef void(^RSConfigurationBuilderBlock)(RSConfigurationBuilder *builder);
typedef void(^RSCallback)(NSArray<RSLink *> *links, NSError *error);

@interface RSSearchConfiguration : NSObject

@property (readonly, strong, nonatomic) NSString *query;
@property (readonly, nonatomic) NSInteger batchNumber;
@property (readonly, nonatomic) NSInteger limit;
@property (readonly, nonatomic, getter=isTopItemsOnly) BOOL topItemsOnly;

@property (strong, nonatomic) NSString *before;
@property (strong, nonatomic) NSString *after;

+ (instancetype)configurationWithBlock:(RSConfigurationBuilderBlock)block;

- (instancetype)initWithBuilder:(RSConfigurationBuilder *)builder;

@end

@interface RSConfigurationBuilder : NSObject

@property (strong, nonatomic) NSString *query;
@property (nonatomic) NSInteger batchNumber;
@property (nonatomic) NSInteger limit;

- (RSSearchConfiguration *)build;

@end
