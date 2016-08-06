//
//  RSNetworkManager.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSApiClient.h"

@implementation RSApiClient

- (void)performRequest:(NSURLRequest *)request withCallback:(NetworkCallback)callback {
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (data) {
            NSError *error = nil;
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:&error];
            callback(object, httpResponse.statusCode, error ?: connectionError);
        } else {
            callback(nil, httpResponse.statusCode, connectionError);
        }
    }];
}

@end
