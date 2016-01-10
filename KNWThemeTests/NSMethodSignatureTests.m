//
//  NSMethodSignatureTests.m
//  KNWTheme
//
//  Created by William on 1/23/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSMethodSignature+KNWTheme.h"

@interface NSMethodSignatureTests : XCTestCase

@end

@implementation NSMethodSignatureTests

- (void)test_substituteObjectForScalarArgument
{
    // Given
    //
    NSMethodSignature
    *original = [[UILabel alloc] methodSignatureForSelector:@selector(setNumberOfLines:)];
    
    // When
    //
    NSMethodSignature
    *substituted = [original knw_methodSignatureBySubstitutingObjectArguments];
    
    // Then
    //
    XCTAssertTrue(0 == strcmp(original.methodReturnType, substituted.methodReturnType));
    XCTAssertTrue(0 == strcmp([original getArgumentTypeAtIndex:0], [substituted getArgumentTypeAtIndex:0]));
    XCTAssertTrue(0 == strcmp([original getArgumentTypeAtIndex:1], [substituted getArgumentTypeAtIndex:1]));
    XCTAssertTrue(0 == strcmp(@encode(id), [substituted getArgumentTypeAtIndex:2]));
}

- (void)test_substituteObjectForStructArgument
{
    // Given
    //
    NSMethodSignature
    *original = [[UIView alloc] methodSignatureForSelector:@selector(setFrame:)];
    
    // When
    //
    NSMethodSignature
    *substituted = [original knw_methodSignatureBySubstitutingObjectArguments];
    
    // Then
    //
    XCTAssertTrue(0 == strcmp(original.methodReturnType, substituted.methodReturnType));
    XCTAssertTrue(0 == strcmp([original getArgumentTypeAtIndex:0], [substituted getArgumentTypeAtIndex:0]));
    XCTAssertTrue(0 == strcmp([original getArgumentTypeAtIndex:1], [substituted getArgumentTypeAtIndex:1]));
    XCTAssertTrue(0 == strcmp(@encode(id), [substituted getArgumentTypeAtIndex:2]));
}

@end
