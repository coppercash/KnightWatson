//
//  KNWThemableObjectProxy.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KNWThemableObjectProxy.h"

#import "KNWThemeContext.h"
#import "NSInvocation+KNWTheme.h"

@interface KNWThemeContext (Internal)
- (void)registerThemableObject:(NSObject *)object
                withInvocation:(NSInvocation *)invocation;
@end

@implementation KNWThemableObjectProxy

- (instancetype)initWithTarget:(NSObject *)target
{
    _target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    KNWThemeContext
    *context = KNWThemeContext.sharedThemeContext;
    
    // Register invocation to target on context
    //
    NSInvocation
    *copied = invocation.knw_methodArgumentsCopy;
    copied.target = nil;
    [copied retainArguments];
    [context registerThemableObject:_target
                     withInvocation:copied];
    
    // Invoke invocation once
    //
    [invocation knw_invokeWithTarget:_target
                               theme:context.theme];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

@end
