//
//  KNWThemedObjectProxy.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KNWThemedObjectProxy.h"

#import "KNWThemeContext.h"
#import "NSInvocation+KNWTheme.h"

@implementation KNWThemedObjectProxy

- (instancetype)initWithTarget:(NSObject *)target
{
    _target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation knw_invokeWithTarget:_target
                              theme:KNWThemeContext.sharedThemeContext.theme];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

@end
