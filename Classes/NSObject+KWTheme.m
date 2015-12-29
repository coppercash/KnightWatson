//
//  NSObject+KWTheme.m
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSObject+KWTheme.h"

#import "KWThemedObjectProxy.h"
#import "KWThemableObjectProxy.h"

@implementation NSObject (KWTheme)

- (instancetype)kw_themed {
    return (NSObject *)[[KWThemedObjectProxy alloc] initWithTarget:self];
}

- (instancetype)kw_themable {
    return (NSObject *)[[KWThemableObjectProxy alloc] initWithTarget:self];
}

@end
