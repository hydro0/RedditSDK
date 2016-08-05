//
//  RedditSDK.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright (c) 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSearchConfiguration.h"

@interface RSInstance : NSObject

+ (instancetype)sharedInstance;

- (void)searchForLinksWithConfiguration:(RSSearchConfiguration *)configuration andCallback:(RSCallback)callback;

@end
