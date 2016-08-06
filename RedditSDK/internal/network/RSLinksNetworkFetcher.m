//
//  RSLinksNetworkFetcher.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSLinksNetworkFetcher.h"
#import "RSSerializerFactory.h"
#import "RSURLProviderFactory.h"

@interface RSLinksNetworkFetcher ()

@property (strong, nonatomic) RSApiClient *apiClient;
@property (strong, nonatomic) id<RSLinksURLProvider> urlProvider;
@property (strong, nonatomic) id<RSLinksSerializer> serializer;

@end

@implementation RSLinksNetworkFetcher

+ (instancetype)fetcherWithDefaultConfigurations {
    return [RSLinksNetworkFetcher fetcherWithAPIClient:[RSApiClient new]
                                       withURLProvider:[RSURLProviderFactory standartURLProvider]
                                        withSerializer:[RSSerializerFactory standartSerializer]];
}

+ (instancetype)fetcherWithAPIClient:(RSApiClient *)apiClient
                     withURLProvider:(id<RSLinksURLProvider>)urlProvider
                      withSerializer:(id<RSLinksSerializer>)serializer {
    return [[RSLinksNetworkFetcher alloc] initWithAPIClient:apiClient
                                            withURLProvider:urlProvider
                                             withSerializer:serializer];
}

- (instancetype)initWithAPIClient:(RSApiClient *)apiClient
                  withURLProvider:(id<RSLinksURLProvider>)urlProvider
                   withSerializer:(id<RSLinksSerializer>)serializer {
    if (self = [super init]) {
        self.apiClient = apiClient;
        self.urlProvider = urlProvider;
        self.serializer = serializer;
    }
    return self;
}

- (void)fetchLinksWithConfiguration:(RSSearchConfiguration *)configuration andCallback:(RSCallback)callback {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self.urlProvider
                                                                        searchLinksURLWithConfiguration:configuration]];
    
    [self.apiClient performRequest:request
                      withCallback:^(NSDictionary *jsonData, NSInteger statusCode, NSError *error) {
                          if (statusCode == 200) {
                              NSArray<RSLink *> *links = [self.serializer linksFromSearchResponse:jsonData];
                              callback(links, nil);
                          } else {
                              callback(nil, error);
                          }
    }];
}

@end
