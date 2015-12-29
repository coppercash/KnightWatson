//
//  NSInvocation+KWTheme.m
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSInvocation+KWTheme.h"

#import "KWThemeValue.h"

@implementation NSInvocation (KWTheme)

- (void)kw_invokeWithTarget:(id)target
                      theme:(id<NSCopying>)theme
{
    for (NSUInteger index = 2; index < self.methodSignature.numberOfArguments; index++) {
        id __unsafe_unretained
        argument;
        [self getArgument:&argument
                  atIndex:index];
        if ([argument isKindOfClass:KWThemeValue.class]) {
            id
            value = [(KWThemeValue *)argument valuesByTheme][theme];
            [self setArgument:&value
                      atIndex:index];
        }
    }
    
    [self invokeWithTarget:target];
}

- (instancetype)kw_copy
{
    NSInvocation
    *invocation = [NSInvocation invocationWithMethodSignature:self.methodSignature];
    invocation.target = self.target;
    invocation.selector = self.selector;
    
    for (NSUInteger index = 2; index < self.methodSignature.numberOfArguments; index++) {
        id __unsafe_unretained
        argument;
        [self getArgument:&argument
                  atIndex:index];
        [invocation setArgument:&argument
                        atIndex:index];
    }
    
    if (self.argumentsRetained) {
        [invocation retainArguments];
    }
    
    return invocation;
}

@end
