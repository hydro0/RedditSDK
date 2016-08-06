//
//  ConfigurationValidatorTest.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/6/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSConfigurationValidator.h"

@interface ConfigurationValidatorTest : XCTestCase

@end

@implementation ConfigurationValidatorTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNilConfigurationAndNilError {
    XCTAssertFalse([RSConfigurationValidator validateConfiguration:nil withError:nil]);
}

- (void)testNilConfigurationAndError {
    NSError *error;
    XCTAssertFalse([RSConfigurationValidator validateConfiguration:nil withError:&error]);
    XCTAssertNotNil(error);
}

- (void)testEmptyQuery {
    RSSearchConfiguration *config = [RSSearchConfiguration configurationWithBlock:^(RSConfigurationBuilder *builder) {
        builder.limit = 25;
        builder.batchNumber = 0;
        builder.query = @"";
    }];
    XCTAssertFalse([RSConfigurationValidator validateConfiguration:config withError:nil]);
}

- (void)testInvalidLimit {
    RSSearchConfiguration *config = [RSSearchConfiguration configurationWithBlock:^(RSConfigurationBuilder *builder) {
        builder.limit = -2;
        builder.batchNumber = 0;
        builder.query = @"query";
    }];
    XCTAssertFalse([RSConfigurationValidator validateConfiguration:config withError:nil]);
}

- (void)testInvalidBatchNumber {
    RSSearchConfiguration *config = [RSSearchConfiguration configurationWithBlock:^(RSConfigurationBuilder *builder) {
        builder.limit = 25;
        builder.batchNumber = -100;
        builder.query = @"query";
    }];
    XCTAssertFalse([RSConfigurationValidator validateConfiguration:config withError:nil]);
}

- (void)testWithSpecificBatchNumber {
    RSSearchConfiguration *config = [RSSearchConfiguration configurationWithBlock:^(RSConfigurationBuilder *builder) {
        builder.limit = 25;
        builder.batchNumber = RSBatchNumberTopItems;
        builder.query = @"query";
    }];
    NSError *error;
    XCTAssertTrue([RSConfigurationValidator validateConfiguration:config withError:&error]);
    XCTAssertNil(error);
    XCTAssertTrue(config.isTopItemsOnly);
}

- (void)testWithValidConfigurationAndPositiveBatch {
    RSSearchConfiguration *config = [RSSearchConfiguration configurationWithBlock:^(RSConfigurationBuilder *builder) {
        builder.limit = 25;
        builder.batchNumber = 3;
        builder.query = @"query";
    }];
    NSError *error;
    XCTAssertTrue([RSConfigurationValidator validateConfiguration:config withError:&error]);
    XCTAssertNil(error);
    XCTAssertFalse(config.isTopItemsOnly);
}



@end
