//
//  NSObject+KNWTheme.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSObject+KNWTheme.h"

#import "KNWThemableObjectProxy.h"

@implementation NSObject (KNWTheme)

- (instancetype)knw_themed {
    return [(id)[[KNWThemableObjectProxy alloc] initWithTarget:self] setKeepThemable:YES];
}

- (instancetype)knw_themable {
    return (id)[[KNWThemableObjectProxy alloc] initWithTarget:self];
}

@end

/*
 * These method implementations only exist to please complier.
 * Because we don't worry about that they would be overrided, the prefix are omitted.
 */
@implementation NSObject (KNWThemablyInvoking)

- (instancetype(^)(NSDictionary *))argsByIndex { return nil; }
- (instancetype)substituteArgumentsByIndex:(NSDictionary *)argsByIndex { return nil; }

- (instancetype)setKeepThemable:(BOOL)keep { return nil; }
- (instancetype(^)(BOOL))keepThemable { return nil; }

@end
