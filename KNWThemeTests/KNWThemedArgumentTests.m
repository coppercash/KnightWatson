//
//  KNWThemedArgumentTests.m
//  KNWTheme
//
//  Created by William on 2/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <KnightWatson/KnightWatson.h>

@interface KNWThemedArgumentTests : XCTestCase

@end

@implementation KNWThemedArgumentTests

- (void)test_dictionary
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    view.knw_themed.backgroundColor =
    [KNWThemedArgument dictionary:@{@"A": UIColor.whiteColor, @"B": UIColor.blackColor,}];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.blackColor, view.backgroundColor);
}

- (void)test_array
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @1;
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    view.knw_themed.backgroundColor =
    [KNWThemedArgument array:@[UIColor.whiteColor, UIColor.blackColor,]];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.blackColor, view.backgroundColor);
}

- (void)test_values
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @1;
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    view.knw_themed.backgroundColor =
    [KNWThemedArgument values:UIColor.whiteColor, UIColor.blackColor, nil];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.blackColor, view.backgroundColor);
}

- (void)test_nonObjectArguments
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    [view
     .knw_themed
     .argAtIndex(0, [KNWThemedArgument dictionary:
                     @{@"A": @42,
                       @"B": @24,}])
     setTag:NSNotFound];
    
    // Then
    //
    XCTAssertEqual(24, view.tag);
}

@end
