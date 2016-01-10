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
    KNWThemeContext.defaultThemeContext.theme = @1;
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    view
    .knw_themable
    .takeNonObjectArgs
    .tag = (NSInteger)@[@4, @2,];
    
    // Then
    //
    XCTAssertEqual(view.tag, 2);
}

- (void)test_doubleArguments
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @1;
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    view
    .knw_themable
    .takeNonObjectArgs
    .alpha = (NSInteger)@[@4, @2,];
    
    // Then
    //
    XCTAssertEqual(view.tag, 2);
}

typedef struct PointerWrapper {
    id __unsafe_unretained pointer;
} PointerWrapper ;

- (void)test_structArguments
{
    // Given
    //
    KNWThemeContext.defaultThemeContext.theme = @1;
    UIView
    *view = [[UIView alloc] init];
    
    // When
    //
    NSArray
    *array = @[[NSValue valueWithCGRect:CGRectMake(1., 1., 1., 1.)], [NSValue valueWithCGRect:CGRectMake(2., 2., 2., 2.)],];
    void
    *a = &array;
    NSArray
    *b = *((NSArray *__unsafe_unretained*)a);
    
    
    view
    .knw_themable
    .takeNonObjectArgs
    .frame = *(CGRect *)(a);
    
    // Then
    //
    XCTAssertEqual(1., view.frame.origin.x);
    XCTAssertEqual(1., view.frame.origin.y);
    XCTAssertEqual(1., view.frame.size.width);
    XCTAssertEqual(1., view.frame.size.height);
}

@end
