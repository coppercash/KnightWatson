//
//  KWThemedObjectProxy.m
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KWThemedObjectProxy.h"

#import "KWThemeContext.h"
#import "NSInvocation+KWTheme.h"

@implementation KWThemedObjectProxy

- (instancetype)initWithTarget:(NSObject *)target
{
    _target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation kw_invokeWithTarget:_target
                              theme:KWThemeContext.sharedThemeContext.theme];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

@end
