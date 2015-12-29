//
//  KWThemableObjectProxy.m
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KWThemableObjectProxy.h"

#import "KWThemeContext.h"
#import "NSInvocation+KWTheme.h"

@interface KWThemeContext (Internal)
- (void)registerThemableObject:(NSObject *)object
                withInvocation:(NSInvocation *)invocation;
@end

@implementation KWThemableObjectProxy

- (instancetype)initWithTarget:(NSObject *)target
{
    _target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    KWThemeContext
    *context = KWThemeContext.sharedThemeContext;
    
    // Register invocation to target on context
    //
    NSInvocation
    *copied = invocation.kw_copy;
    copied.target = nil;
    [copied retainArguments];
    [context registerThemableObject:_target
                     withInvocation:copied];
    
    // Invoke invocation once
    //
    [invocation kw_invokeWithTarget:_target
                           theme:context.theme];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

@end
