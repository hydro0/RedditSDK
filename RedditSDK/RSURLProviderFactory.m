//
//  RSURLProviderFactory.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSURLProviderFactory.h"
#import "RSRedditURLProvider.h"

@implementation RSURLProviderFactory

+ (id<RSLinksURLProvider>)standartURLProvider {
    return [RSRedditURLProvider new];
}

@end
