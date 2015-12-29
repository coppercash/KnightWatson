//
//  KWThemeContext.m
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KWThemeContext.h"

#import "NSObject+KWTheme.h"
#import "NSInvocation+KWTheme.h"

#import <objc/runtime.h>

@interface NSObject (KWThemableObjectProxy)
@property (readonly) NSMutableDictionary *kw_invocationsByMethod;
@end

@implementation KWThemeContext

+ (instancetype)sharedThemeContext
{
    KWThemeContext static
    *_instance = nil;
    dispatch_once_t static
    _predicate;
    dispatch_once(&_predicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _themableObjects = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

- (void)setTheme:(id<NSCopying>)theme
{
    _theme = theme;
    
    for (NSObject *object in _themableObjects) {
        for (NSInvocation *invocation in object.kw_invocationsByMethod.allValues) {
            [invocation.kw_copy kw_invokeWithTarget:object
                                      theme:theme];
        }
    }
}

#pragma mark -

- (void)registerThemableObject:(NSObject *)object
                withInvocation:(NSInvocation *)invocation
{
    NSParameterAssert(nil != object);
    NSParameterAssert(nil != invocation);
    NSParameterAssert(invocation.argumentsRetained);
    NSParameterAssert(nil == invocation.target);
    NSParameterAssert(NULL != invocation.selector);
    
    // Context weakly refers the target object
    //
    if (NO == [_themableObjects containsObject:object]) {
        [_themableObjects addObject:object];
    }
    
    // Map retained invocation by selector on object
    //
    object.kw_invocationsByMethod[NSStringFromSelector(invocation.selector)] = invocation;
}

@end

@implementation NSObject (KWThemableObjectProxy)

- (NSMutableDictionary *)kw_invocationsByMethod {
    NSMutableDictionary
    *invocations = objc_getAssociatedObject(self, _cmd);
    if (nil == invocations) {
        objc_setAssociatedObject(self,
                                 _cmd,
                                 (invocations = [[NSMutableDictionary alloc] init]),
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return invocations;
}

@end
