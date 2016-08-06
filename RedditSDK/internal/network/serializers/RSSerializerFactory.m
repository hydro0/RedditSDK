//
//  RSSerializerFactory.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSSerializerFactory.h"
#import "RSStandartLinksSerializer.h"

@implementation RSSerializerFactory

+ (id<RSLinksSerializer>)standartSerializer {
    return [RSStandartLinksSerializer new];
}

@end
