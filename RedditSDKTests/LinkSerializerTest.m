//
//  LinkSerializerTest.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/6/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSStandartLinksSerializer.h"

@interface LinkSerializerTest : XCTestCase

@property (strong, nonatomic) RSStandartLinksSerializer *serializer;

@end

@implementation LinkSerializerTest

- (void)setUp {
    [super setUp];
    self.serializer = [RSStandartLinksSerializer new];
}

- (void)tearDown {
    self.serializer = nil;
    [super tearDown];
}

- (void)testNilCase {
    NSDictionary *response = nil;
    NSArray *array = [self.serializer linksFromSearchResponse:response];
    XCTAssertNil(array);
}

- (void)testEmptyDictionaryCase {
    NSDictionary *response = @{};
    NSArray *array = [self.serializer linksFromSearchResponse:response];
    XCTAssertNil(array);
}

- (void)testCorrectDictionaryWithEmptyChildren {
    NSDictionary *response = @{ @"data": @{ @"children": @[] } };
    NSArray *array = [self.serializer linksFromSearchResponse:response];
    XCTAssertNotNil(array);
    XCTAssertEqual(array.count, 0);
}

- (void)testIncorrectChildrenObjects {
    NSDictionary *response = @{ @"data": @{ @"children": @[@{}, @{}, @{}] } };
    NSArray *array = [self.serializer linksFromSearchResponse:response];
    [array enumerateObjectsUsingBlock:^(RSLink * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNotNil(obj);
        XCTAssertNil(obj.title);
        XCTAssertNil(obj.createdAt);
        XCTAssertNil(obj.thumbnailURL);
    }];
    XCTAssertNotNil(array);
    XCTAssertEqual(array.count, [response[@"data"][@"children"] count]);
}

- (void)testCorrectChildrenObjects {
    NSDate *date = [NSDate new];
    NSDictionary *child = @{ @"title": @"hello",
                             @"created":[NSNumber numberWithLong:date.timeIntervalSince1970],
                             @"thumbnail":@"self"
                             };
    NSDictionary *response = @{ @"data":
                                    @{ @"children":
                                           @[
                                               @{ @"data" : child }
                                               ]
                                       }
                                };
    NSArray *array = [self.serializer linksFromSearchResponse:response];
    RSLink *link = array.firstObject;
    XCTAssertTrue([link.title isEqualToString:child[@"title"]], @"%@ is not equal to %@", link.title, child[@"title"]);
    XCTAssertTrue([link.thumbnailURL isEqualToString:child[@"thumbnail"]], @"%@ is not equal to %@", link.thumbnailURL, child[@"thumbnail"]);
    XCTAssertEqualWithAccuracy(link.createdAt.timeIntervalSince1970, date.timeIntervalSince1970, 1, @"%@ is not equal to %@", link.createdAt, date);
    
    XCTAssertNotNil(array);
    XCTAssertEqual(array.count, [response[@"data"][@"children"] count]);
}

- (void)testCheckOrdering {
    NSMutableArray *children = [NSMutableArray new];
    for (int i = 0; i < 50; i++) {
        [children addObject:@{@"data" : @{
                                      @"title": [NSString stringWithFormat:@"child%d", i]
                                      }
                              }];
    }
    
    NSDictionary *response = @{ @"data":
                                    @{ @"children":
                                           [children copy]
                                       }
                                };
    
    NSArray *array = [self.serializer linksFromSearchResponse:response];
    [array enumerateObjectsUsingBlock:^(RSLink * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *mocked = [children objectAtIndex:idx][@"data"][@"title"];
        XCTAssertTrue([obj.title isEqualToString:mocked], @"In %lu position %@ is not equals to %@", (unsigned long)idx, obj.title, mocked);
    }];
    
    XCTAssertNotNil(array);
    XCTAssertEqual(array.count, [response[@"data"][@"children"] count]);
}

@end
