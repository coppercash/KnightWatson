//
//  KNWNonObjectArgumentsTests.m
//  KNWTheme
//
//  Created by William on 1/10/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <KNWTheme/KNWTheme.h>

@interface KNWNonObjectArgumentsTests : XCTestCase

@end

@implementation KNWNonObjectArgumentsTests

- (void)test_integerArguments
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    [view
     .knw_themable
     .argsByIndex(@{@0: @{@"A": @3, @"B": @4}})
     setTag:0];
    
    // Then
    //
    XCTAssertEqual(view.tag, 4);
}

- (void)test_doubleArguments
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    [view
     .knw_themable
     .argsByIndex(@{@0: @{@"A": @3., @"B": @4.}})
     setAlpha:0.];
    
    // Then
    //
    XCTAssertEqual(view.alpha, 4.);
}

- (void)test_structArguments
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    [view
     .knw_themable
     .argsByIndex(@{@0: @{@"A": [NSValue valueWithCGRect:CGRectMake(1., 1., 1., 1.)],
                          @"B": [NSValue valueWithCGRect:CGRectMake(2., 2., 2., 2.)],}
                    })
     setFrame:CGRectZero];
    
    // Then
    //
    XCTAssertEqual(2., view.frame.origin.x);
    XCTAssertEqual(2., view.frame.origin.y);
    XCTAssertEqual(2., view.frame.size.width);
    XCTAssertEqual(2., view.frame.size.height);
}

- (void)test_objectaArgsByIndex
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    [view
     .knw_themable
     .argsByIndex(@{@0: @{@"A": UIColor.whiteColor,
                          @"B": UIColor.blackColor,}
                    })
     setBackgroundColor:nil];
    
    // Then
    //
    XCTAssertEqualObjects(UIColor.blackColor, view.backgroundColor);
}

- (void)test_argsByIndex
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    [view
     .knw_themable
     .argsByIndex(@{@0: @{@"A": @42,
                          @"B": @24,}
                    })
     setTag:NSNotFound];
    
    // Then
    //
    XCTAssertEqual(24, view.tag);
}

- (void)test_argAtIndex
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @"B";
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    [view
     .knw_themable
     .argAtIndex(0, @{@"A": @42,
                      @"B": @24,})
     setTag:NSNotFound];
    
    // Then
    //
    XCTAssertEqual(24, view.tag);
}

@end
