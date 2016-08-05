//
//  RSLink.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSLink : NSObject

@property (readonly, strong, nonatomic) NSString *idx;
@property (readonly, strong, nonatomic) NSString *title;
@property (readonly, strong, nonatomic) NSDate *createdAt;
@property (readonly, strong, nonatomic) NSString *fullName;

+ (instancetype)linkWithDictionary:(NSDictionary *)dictionary;

@end
