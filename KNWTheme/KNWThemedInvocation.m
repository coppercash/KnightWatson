//
//  KNWThemedInvocation.m
//  KNWTheme
//
//  Created by William on 1/31/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWThemedInvocation.h"

#import "KNWThemeContext.h"
#import "NSInvocation+KNWTheme.h"
#import "NSObject+KNWThemable.h"

@interface KNWThemedInvocation ()

@property (readwrite, nonatomic) NSInvocation *invocation;
@property (readwrite, nonatomic) NSDictionary *argumentsByIndex;
@property (readwrite, nonatomic) KNWThemeContext *context;

@end

@implementation KNWThemedInvocation
@synthesize
invocation = _invocation,
argumentsByIndex = _argumentsByIndex,
context = _context;

- (void)invokeWithTarget:(NSObject *)target
{
    NSParameterAssert(target);
    
    NSInvocation
    *settled =
    [_invocation knw_invocationBySubstitutingArguments:_argumentsByIndex
                                          themeContext:_context];
    [settled invokeWithTarget:target];
}

@end

#pragma mark - KNWThemedInvocationBuilder -

@interface KNWThemedInvocationBuilder ()

@property (strong, nonatomic) NSMutableDictionary *argumentsByIndex;
@property (weak, nonatomic) KNWThemeContext *context;
@property (readwrite, nonatomic) BOOL invokeOnce;

@end

@implementation KNWThemedInvocationBuilder
@synthesize
invokeOnce = _invokeOnce;

- (KNWThemedInvocation *)buildWithMethodInvocation:(NSInvocation *)invocation
{
    NSParameterAssert(invocation);
    
    KNWThemedInvocation
    *themedInvocation = [[KNWThemedInvocation alloc] init];
    
    // Invocation
    //
    NSInvocation
    *copied = invocation.knw_methodArgumentsCopy;
    copied.target = nil;
    [copied retainArguments];
    themedInvocation.invocation = copied;

    // Substituting arguements
    //
    themedInvocation.argumentsByIndex = _argumentsByIndex.copy;
    
    // Context
    //
    themedInvocation.context = self.context;
    
    return themedInvocation;
}

- (KNWThemeContext *)context
{
    if (_context) {
        return _context;
    }
    return (_context = KNWThemeContext.defaultThemeContext);
}

#pragma mark - NSObject (KNWThemablyInvoking)

- (instancetype)substituteArgumentsByIndex:(NSDictionary *)argsByIndex
{
    [self.argumentsByIndex addEntriesFromDictionary:argsByIndex];
    return nil;
}

- (NSMutableDictionary *)argumentsByIndex
{
    if (_argumentsByIndex) {
        return _argumentsByIndex;
    }
    return (_argumentsByIndex = [[NSMutableDictionary alloc] init]);
}

- (instancetype)setKeepThemable:(BOOL)keep
{
    _invokeOnce = !keep;
    return nil;
}

- (instancetype)substituteArgument:(id)argument
                           atIndex:(NSUInteger)index
{
    self.argumentsByIndex[@(index)] = argument;
    return nil;
}

@end
