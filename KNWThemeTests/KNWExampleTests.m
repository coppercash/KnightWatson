//
//  KNWExampleTests.m
//  KNWTheme
//
//  Created by William on 1/9/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <KnightWatson/KnightWatson.h>

@interface KNWExampleTests : XCTestCase

@end

@implementation KNWExampleTests

- (void)test_basic
{
    // Configure the instance with values by theme
    //
    UIView
    *view = [[UIView alloc] init];
    view.knw_themed.backgroundColor = (id)@{@"daylight": UIColor.whiteColor,
                                            @"night": UIColor.blackColor,};

    // Change the theme sometime later
    //
    KNWThemeContext.defaultThemeContext.theme = @"night";
}

- (void)test_non_object_arguments
{
    KNWThemeContext.defaultThemeContext.theme = @"theme_a";
    
    UIView
    *view = [[UIView alloc] init];
    NSDictionary
    *framesByTheme =
    @{@"theme_a": [NSValue valueWithCGRect:CGRectMake(1., 1., 1., 1.)],
      @"theme_b": [NSValue valueWithCGRect:CGRectMake(2., 2., 2., 2.)],};
    
    [view
     .knw_themable
     .argAtIndex(0, framesByTheme)
     setFrame:CGRectZero];
}

- (void)test_short_lifetime
{
    KNWThemeContext.defaultThemeContext.theme = @"night";
    
    UIView
    *view = [[UIView alloc] init];
    NSDictionary
    *colorsByTheme = @{@"daylight": UIColor.whiteColor,
                       @"night": UIColor.blackColor,};
    [view
     .knw_themable
     .keepThemable(NO)
     setBackgroundColor:(id)colorsByTheme];
    
    view.knw_themed.backgroundColor = (id)@{@"daylight": UIColor.whiteColor,
                                            @"night": UIColor.blackColor,};
}

- (void)test_can_be_a_theme
{
    KNWThemeContext.defaultThemeContext.theme = @1;
    
    UIButton
    *button = [[UIButton alloc] init];
    NSArray
    *colorsByTheme = @[UIColor.whiteColor, UIColor.blackColor,];
    [button.knw_themable setTitleColor:(id)colorsByTheme
                              forState:UIControlStateNormal];
}

@end
