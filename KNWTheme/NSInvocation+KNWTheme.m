//
//  NSInvocation+KNWTheme.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSInvocation+KNWTheme.h"

#import "KNWThemableValue.h"
#import "KNWThemeContext.h"

@implementation NSInvocation (KNWTheme)

- (void)knw_invokeWithTarget:(id)target
                themeContext:(KNWThemeContext *)context
{
    NSMethodSignature
    *signature = self.methodSignature;
    for (NSUInteger index = 2; index < signature.numberOfArguments; index++) {
        char const
        *type = [signature getArgumentTypeAtIndex:index];
        if (0 != strcmp("@", type)) { continue; }
        
        id __unsafe_unretained
        argument;
        [self getArgument:&argument
                  atIndex:index];
        if (NO == [argument conformsToProtocol:@protocol(KNWThemableValue)]) { continue; }
        
        id
        value = [argument respondsToSelector:@selector(knw_valueWithThemeContext:)] ?
        [(id<KNWThemableValue>)argument knw_valueWithThemeContext:context] :
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [(id<KNWThemableValue>)argument knw_valueByTheme:context.theme];
#pragma clang diagnostic pop
        [self setArgument:&value
                  atIndex:index];
    }
    
    [self invokeWithTarget:target];
}

- (instancetype)knw_methodArgumentsCopy
{
    NSInvocation
    *invocation = [NSInvocation invocationWithMethodSignature:self.methodSignature];
    invocation.selector = self.selector;
    
    for (NSUInteger index = 2; index < self.methodSignature.numberOfArguments; index++) {
        id __unsafe_unretained
        argument;
        [self getArgument:&argument
                  atIndex:index];
        [invocation setArgument:&argument
                        atIndex:index];
    }
    
    return invocation;
}

@end
