//
//  KNWThemeTests.m
//  KNWThemeTests
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "KNWThemeContext.h"
#import "KNWThemeValue.h"
#import "NSObject+KNWTheme.h"

@interface KNWThemeTests : XCTestCase

@end

@implementation KNWThemeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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
    // Given
    //
    KNWThemeContext.sharedThemeContext.theme = @0;
    
    // When
    UIView
    *view = [[UIView alloc] init];
    view.knw_themed.backgroundColor = [KNWThemeValue values:UIColor.whiteColor, UIColor.blackColor, nil];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.whiteColor, view.backgroundColor);
}

- (void)testAPI2 {
    UIView
    *view = [[UIView alloc] init];
    
    view.knw_themable.backgroundColor = [KNWThemeValue values:UIColor.whiteColor, UIColor.blackColor, nil];
    
    [[KNWThemeContext sharedThemeContext] setTheme:@0];
    XCTAssertEqualObjects(UIColor.whiteColor, view.backgroundColor);
    [[KNWThemeContext sharedThemeContext] setTheme:@1];
    XCTAssertEqualObjects(UIColor.blackColor, view.backgroundColor);
}

- (void)testAPI3 {
    UIView
    *view = [[UIView alloc] init];
    UIView __weak
    *deallocTester = view;
    
    view.knw_themable.backgroundColor = [KNWThemeValue array:@[UIColor.whiteColor, UIColor.blackColor,]];
    view = nil;
    
    XCTAssertNil(deallocTester);
}

- (void)testAPI4 {
    UIButton
    *view = [[UIButton alloc] init];
    
    [view.knw_themable setTitleColor:[KNWThemeValue dictionary:@{@"A": UIColor.whiteColor, @"B": UIColor.blackColor,}]
                            forState:UIControlStateHighlighted];
    
    [[KNWThemeContext sharedThemeContext] setTheme:@"A"];
    XCTAssertEqualObjects(UIColor.whiteColor, [view titleColorForState:UIControlStateHighlighted]);
    [[KNWThemeContext sharedThemeContext] setTheme:@"B"];
    XCTAssertEqualObjects(UIColor.blackColor, [view titleColorForState:UIControlStateHighlighted]);
}

@end
