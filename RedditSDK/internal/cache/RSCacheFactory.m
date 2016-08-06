//
//  RSCacheFactory.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSCacheFactory.h"
#import "RSRuntimeLinksCache.h"

@implementation RSCacheFactory

+ (id<RSLinksCache>)runtimeCache {
    return [RSRuntimeLinksCache new];
}

@end
