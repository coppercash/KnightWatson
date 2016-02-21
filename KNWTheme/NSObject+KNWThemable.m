//
//  NSObject+KNWTheme.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSObject+KNWThemable.h"

#import "KNWThemableObjectProxy.h"

@implementation NSObject (KNWThemable)

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

- (instancetype)substituteArgument:(id)argument atIndex:(NSUInteger)index { return nil; }
- (instancetype(^)(NSUInteger, id))argAtIndex { return nil; }

- (instancetype)setKeepThemable:(BOOL)keep { return nil; }
- (instancetype(^)(BOOL))keepThemable { return nil; }

@end

@implementation NSObject (KNWConvenientlyThemable)

- (instancetype)knw_themed {
    return (id)[[[KNWThemableObjectProxy alloc] initWithTarget:self] setKeepThemable:NO];
}

@end
