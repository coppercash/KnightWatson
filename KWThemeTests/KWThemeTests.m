//
//  KWThemeTests.m
//  KWThemeTests
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "KWThemeContext.h"
#import "KWThemeValue.h"
#import "NSObject+KWTheme.h"

@interface KWThemeTests : XCTestCase

@end

@implementation KWThemeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [[KWThemeContext sharedThemeContext] setTheme:@"A"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testAPI {
    UIView
    *view = [[UIView alloc] init];
    
    view.kw_themed.backgroundColor = (UIColor *)[[KWThemeValue alloc] initWithValuesByTheme:
                                                 @{
                                                   @"A": UIColor.whiteColor,
                                                   @"B": UIColor.blackColor
                                                   }];
    
    XCTAssertEqualObjects(UIColor.whiteColor, view.backgroundColor);
}

@end
