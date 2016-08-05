//
//  RSNetworkManager.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSApiClient : NSObject

typedef void(^NetworkCallback)(NSDictionary *jsonData, NSInteger statusCode, NSError *error);

- (void)performRequest:(NSURLRequest *)request withCallback:(NetworkCallback)callback;

@end
