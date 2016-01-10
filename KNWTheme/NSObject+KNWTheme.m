//
//  NSObject+KNWTheme.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSObject+KNWTheme.h"

#import "KNWThemedObjectProxy.h"
#import "KNWThemableObjectProxy.h"

@implementation NSObject (KNWTheme)

- (instancetype)knw_themed {
    return (NSObject *)[[KNWThemedObjectProxy alloc] initWithTarget:self];
}

- (instancetype)knw_themable {
    return (NSObject *)[[KNWThemableObjectProxy alloc] initWithTarget:self];
}

/*
 * These method implementations only exist to please complier.
 * Because we don't worry about that they would be overrided, the prefix are omitted.
 */
- (instancetype)takeNonObjectArgs { return self; }

@end
