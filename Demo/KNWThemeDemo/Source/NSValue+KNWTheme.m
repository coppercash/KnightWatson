//
//  NSValue+KNWTheme.m
//  KNWThemeDemo
//
//  Created by William on 3/20/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "NSValue+KNWTheme.h"

@implementation NSValue (KNWTheme)

+ (instancetype)knw_valueWithCGColorRef:(CGColorRef)colorRef
{
    return [self valueWithBytes:&colorRef objCType:@encode(CGColorRef)];
}

@end
