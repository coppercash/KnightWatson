//
//  KNWThemableObjectProxy.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+KNWTheme.h"

@class KNWThemedInvocationBuilder;

@interface KNWThemableObjectProxy : NSProxy <KNWThemablyInvoking>
{
    NSObject __unsafe_unretained
    *_target;
    KNWThemedInvocationBuilder
    *_builder;
}

- (instancetype)initWithTarget:(NSObject *)target;

@end
