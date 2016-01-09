//
//  KNWThemeTests.m
//  KNWThemeTests
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <KNWTheme/KNWTheme.h>

@interface KNWThemeTests : XCTestCase

@end

@implementation KNWThemeTests

- (void)test_themedObject
{
    // Given
    //
    KNWThemeContext.sharedThemeContext.theme = @0;
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    view.knw_themed.backgroundColor = [KNWThemeValue values:UIColor.whiteColor, UIColor.blackColor, nil];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.whiteColor, view.backgroundColor);
}

- (void)test_themableObject
{
    // Given
    //
    KNWThemeContext.sharedThemeContext.theme = @0;
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    view.knw_themable.backgroundColor = [KNWThemeValue values:UIColor.whiteColor, UIColor.blackColor, nil];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.whiteColor, view.backgroundColor);
}

- (void)test_themableObjectWillBeReThemed
{
    // Given
    //
    KNWThemeContext.sharedThemeContext.theme = @0;
    UIView
    *view = [[UIView alloc] init];
    view.knw_themable.backgroundColor = [KNWThemeValue values:UIColor.whiteColor, UIColor.blackColor, nil];
    
    // When
    //
    KNWThemeContext.sharedThemeContext.theme = @1;
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.blackColor, view.backgroundColor);
}

- (void)test_themableObjectWillBeDeallocAsUsual
{
    // Given
    //
    UIView
    *view = [[UIView alloc] init];
    UIView __weak
    *deallocTester = view;
    view.knw_themable.backgroundColor = [KNWThemeValue array:@[UIColor.whiteColor, UIColor.blackColor,]];
    
    // When
    //
    view = nil;
    
    // Then
    //
    XCTAssertNil(deallocTester);
}

- (void)test_passingMoreThanOneArgument
{
    // Given
    //
    UIButton
    *view = [[UIButton alloc] init];
    
    // When
    //
    [[KNWThemeContext sharedThemeContext] setTheme:@"A"];
    [view.knw_themable setTitleColor:[KNWThemeValue dictionary:@{@"A": UIColor.whiteColor, @"B": UIColor.blackColor,}]
                            forState:UIControlStateHighlighted];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.whiteColor, [view titleColorForState:UIControlStateHighlighted]);
}

@end
