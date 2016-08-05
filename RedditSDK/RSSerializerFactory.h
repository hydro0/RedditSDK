//
//  RSSerializerFactory.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSProtocols.h"

@interface RSSerializerFactory : NSObject

+ (id<RSLinksSerializer>)standartSerializer;

@end
