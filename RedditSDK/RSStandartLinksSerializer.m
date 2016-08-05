//
//  RSStandartLinksSerializer.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSStandartLinksSerializer.h"
#import "NSArray+Map.h"
#import "RSLink.h"

@implementation RSStandartLinksSerializer

#pragma mark RSLinksSerializer implementation

- (NSArray<RSLink *> *)linksFromSearchResponse:(NSDictionary *)response {
    NSArray<NSDictionary *> *children = response[@"data"][@"children"];
    
    return [children mapObjectsUsingBlock:^id(NSDictionary *obj, NSUInteger idx) {
        return [RSLink linkWithDictionary:obj];
    }];
}
@end
