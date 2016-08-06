//
//  APIClientTest.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/6/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSApiClient.h"

@interface APIClientTest : XCTestCase

@property (strong, nonatomic) RSApiClient *apiClient;

@end

@implementation APIClientTest

- (void)setUp {
    [super setUp];
    self.apiClient = [RSApiClient new];
}

- (void)tearDown {
    [super tearDown];
    self.apiClient = nil;
}

- (void)testInvalidRequest {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation for HTTP request performing"];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.URL = [NSURL URLWithString:@"NOT_AN_URL"];
    
    [self.apiClient performRequest:request
                      withCallback:^(NSDictionary *jsonData, NSInteger statusCode, NSError *error) {
                          XCTAssertNil(jsonData);
                          XCTAssertNotNil(error);
                          [expectation fulfill];
                      }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Out of time");
        }
    }];
}

- (void)testRequestWithBodyParsingErrorAndValidURL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation for HTTP request performing"];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.URL = [NSURL URLWithString:@"https://www.reddit.com"];
    
    [self.apiClient performRequest:request
                      withCallback:^(NSDictionary *jsonData, NSInteger statusCode, NSError *error) {
                          XCTAssertNil(jsonData);
                          XCTAssertEqual(statusCode, 200);
                          XCTAssertNotNil(error);
                          [expectation fulfill];
                      }];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Out of time");
        }
    }];
}

- (void)testValidRequest {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation for HTTP request performing"];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.URL = [NSURL URLWithString:@"https://www.reddit.com/search/.json?q=ios"];
    
    [self.apiClient performRequest:request
                      withCallback:^(NSDictionary *jsonData, NSInteger statusCode, NSError *error) {
                          XCTAssertNotNil(jsonData);
                          XCTAssertEqual(statusCode, 200);
                          XCTAssertNil(error);
                          [expectation fulfill];
                      }];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Out of time");
        }
    }];
}

@end
