//
//  KNWThemableObjectProxy.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KNWThemableObjectProxy.h"
#import "KNWThemeContext.h"
/* TODO: Remove
 #import "NSInvocation+KNWTheme.h"
 #import "NSMethodSignature+KNWTheme.h"
 */
#import "KNWThemedInvocation.h"

@interface KNWThemeContext (Internal)
- (void)registerThemableObject:(NSObject *)object
                withInvocation:(KNWThemedInvocation *)invocation;
@end
/*
 @interface KNWThemableObjectProxy ()
 @property (strong, nonatomic) NSDictionary *argumentsByIndex;
 @end
 */
@implementation KNWThemableObjectProxy
/* TODO: Remove
 @synthesize
 argumentsByIndex = _argumentsByIndex;
 */
- (instancetype)initWithTarget:(NSObject *)target
{
    _target = target;
    _builder = [[KNWThemedInvocationBuilder alloc] init];
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    /* TODO: Remove
     KNWThemeContext
     *context = KNWThemeContext.defaultThemeContext;
     */
    
    
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
    
    
    
    
    
    /* TODO: Remove
     NSInvocation
     *copied = invocation.knw_methodArgumentsCopy;
     copied.target = nil;
     [copied retainArguments];
     [context registerThemableObject:_target
     withInvocation:copied];
     */
    
    /* TODO: Remove
     NSInvocation
     *settled =
     [invocation knw_invocationBySubstitutingArguments:_argumentsByIndex
     themeContext:context];
     [settled invokeWithTarget:_target];
     */
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}
/* TODO: Remove
 #pragma mark -
 
 - (instancetype(^)(NSDictionary *))argsByIndex
 {
 KNWThemableObjectProxy __unsafe_unretained
 *proxy = self;
 return ^id (NSDictionary *argsByIndex) {
 proxy.argumentsByIndex = argsByIndex;
 return proxy;
 };
 }
 */
#pragma mark - KNWThemablyInvoking

- (instancetype(^)(NSDictionary *))argsByIndex
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
