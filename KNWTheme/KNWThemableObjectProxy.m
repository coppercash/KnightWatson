//
//  KNWThemableObjectProxy.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KNWThemableObjectProxy.h"
#import "KNWThemeContext.h"
#import "KNWThemedInvocation.h"

@interface KNWThemeContext (Internal)
- (void)registerThemableObject:(NSObject *)object
                withInvocation:(KNWThemedInvocation *)invocation;
@end

@implementation KNWThemableObjectProxy

- (instancetype)initWithTarget:(NSObject *)target
{
    _target = target;
    _builder = [[KNWThemedInvocationBuilder alloc] init];
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    KNWThemedInvocation
    *themedInvocation = [_builder buildWithMethodInvocation:invocation];
    
    // Register invocation to target on context
    //
    if (NO == _builder.invokeOnce) {
        [themedInvocation.context registerThemableObject:_target
                                  withInvocation:themedInvocation];
    }
    
    // Invoke invocation once
    //
    [themedInvocation invokeWithTarget:_target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

#pragma mark - KNWThemablyInvoking

- (instancetype(^)(NSDictionary<NSNumber *, id> *))argsByIndex
{
    KNWThemableObjectProxy __unsafe_unretained
    *proxy = self;
    return ^id (NSDictionary *argsByIndex) {
        [proxy->_builder substituteArgumentsByIndex:argsByIndex];
        return proxy;
    };
}

- (instancetype)substituteArgumentsByIndex:(NSDictionary *)argsByIndex
{
    [_builder substituteArgumentsByIndex:argsByIndex];
    return self;
}

- (instancetype)substituteArgument:(id)argument
                           atIndex:(NSUInteger)index
{
    [_builder substituteArgument:argument
                         atIndex:index];
    return self;
}

- (instancetype(^)(NSUInteger, id))argAtIndex
{
    KNWThemableObjectProxy __unsafe_unretained
    *proxy = self;
    return ^id (NSUInteger index, id argument) {
        [proxy->_builder substituteArgument:argument atIndex:index];
        return proxy;
    };
}

- (instancetype)setKeepThemable:(BOOL)keep
{
    [_builder setKeepThemable:keep];
    return self;
}

- (instancetype(^)(BOOL))keepThemable
{
    KNWThemableObjectProxy __unsafe_unretained
    *proxy = self;
    return ^id (BOOL keep) {
        [proxy->_builder setKeepThemable:keep];
        return proxy;
    };
}


@end
