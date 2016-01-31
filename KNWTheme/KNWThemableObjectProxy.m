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
#import "NSMethodSignature+KNWTheme.h"

#import <objc/runtime.h>

@interface KNWThemeContext (Internal)
- (void)registerThemableObject:(NSObject *)object
                withInvocation:(NSInvocation *)invocation;
@end

@interface KNWThemableObjectProxy ()
@property (strong, nonatomic) NSDictionary *argumentsByIndex;
@end

@implementation KNWThemableObjectProxy
@synthesize
argumentsByIndex = _argumentsByIndex;

- (instancetype)initWithTarget:(NSObject *)target
{
    _target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    KNWThemeContext
    *context = KNWThemeContext.defaultThemeContext;
    
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
    NSInvocation
    *settled =
    [invocation knw_invocationBySubstitutingArguments:_argumentsByIndex
                                         themeContext:context];
    [settled invokeWithTarget:_target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature
    *signature = [_target methodSignatureForSelector:sel];
    return
    _takeNonObjectArgs ?
    [signature knw_methodSignatureBySubstitutingObjectArguments] :
    signature;
    
        
/*
        Method
        method = class_getInstanceMethod(_target.class, sel);
        struct objc_method_description* desc =
        method_getDescription(method);

        NSLog(@"✅ %@ %s", NSStringFromSelector(sel), desc->types);
        */
}

#pragma mark - 

- (instancetype)takeNonObjectArgs
{
    _takeNonObjectArgs = YES;
    return self;
}

- (instancetype(^)(NSDictionary *))argsByIndex
{
    KNWThemableObjectProxy __unsafe_unretained
    *proxy = self;
    return ^id (NSDictionary *argsByIndex) {
        proxy.argumentsByIndex = argsByIndex;
        return proxy;
    };
}

@end
