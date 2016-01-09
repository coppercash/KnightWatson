//
//  KNWExampleTests.m
//  KNWTheme
//
//  Created by William on 1/9/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <KNWTheme/KNWTheme.h>

@interface KNWExampleTests : XCTestCase

@end

@implementation KNWExampleTests

- (void)test_main
{
    UIButton
    *button = [[UIButton alloc] init];
    [button.knw_themable setTitleColor:(id)@{@"daylight": UIColor.whiteColor,
                                             @"night": UIColor.blackColor,}
                              forState:UIControlStateNormal];
    
    KNWThemeContext.defaultThemeContext.theme = @"night";
}

@end
