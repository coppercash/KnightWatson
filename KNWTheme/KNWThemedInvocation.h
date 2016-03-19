//
//  KNWThemedInvocation.h
//  KNWTheme
//
//  Created by William on 1/31/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KNWThemeContext;

@interface KNWThemedInvocation : NSObject
{
    NSInvocation
    *_invocation;
    NSDictionary
    *_argumentsByIndex;
    KNWThemeContext __weak
    *_context;
}
@property (readonly, nonatomic) NSInvocation *invocation;
@property (readonly, nonatomic) NSDictionary *argumentsByIndex;
@property (readonly, nonatomic) KNWThemeContext *context;
- (void)invokeWithTarget:(NSObject *)target;
@end

#pragma mark - KNWThemedInvocationBuilder -

@interface KNWThemedInvocationBuilder : NSObject
{
    BOOL
    _invokeOnce;
}
@property (readonly, nonatomic) BOOL invokeOnce;
- (KNWThemedInvocation *)buildWithMethodInvocation:(NSInvocation *)invocation;
@end
