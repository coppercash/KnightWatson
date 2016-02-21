//
//  KNWThemedObjectTests.m
//  KNWTheme
//
//  Created by William on 2/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <KNWTheme/KNWTheme.h>

@interface KNWThemedObjectTests : XCTestCase

@end

@implementation KNWThemedObjectTests

- (void)test_themedObjectWillInvokeMethodOnlyOnce
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @0;
    UIView
    *view = [[UIView alloc] init];
    view.knw_themed.backgroundColor = (id)@[UIColor.whiteColor, UIColor.blackColor,];
    
    // When
    //
    KNWThemeContext.defaultThemeContext.theme = @1;
    
    // Then
    //
    XCTAssertNotEqualObjects(UIColor.blackColor, view.backgroundColor);
}

@end
