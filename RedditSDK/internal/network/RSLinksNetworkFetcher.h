//
//  RSLinksNetworkFetcher.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSearchConfiguration.h"
#import "RSApiClient.h"
#import "RSProtocols.h"

@interface RSLinksNetworkFetcher : NSObject

+ (instancetype)fetcherWithDefaultConfigurations;
+ (instancetype)fetcherWithAPIClient:(RSApiClient *)apiClient
                     withURLProvider:(id<RSLinksURLProvider>)urlProvider
                      withSerializer:(id<RSLinksSerializer>)serializer;
        

- (void)fetchLinksWithConfiguration:(RSSearchConfiguration *)configuration andCallback:(RSCallback)callback;

@end
