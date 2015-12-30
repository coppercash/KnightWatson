//
//  KNWThemeValue.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KNWThemeValue.h"

@implementation KNWThemeValue
@synthesize valuesByTheme = _valuesByTheme;

- (instancetype)initWithValuesByTheme:(NSDictionary *)values
{
    if (self = [super init]) {
        _valuesByTheme = values;
    }
    return self;
}

+ (instancetype)valueWithValues:(NSArray *)values
{
    NSMutableDictionary
    *collector = [[NSMutableDictionary alloc] initWithCapacity:values.count];
    for (NSUInteger index = 0; index < values.count; index++) {
        collector[@(index)] = values[index];
    }
    
    return [[self alloc] initWithValuesByTheme:collector.copy];
}

@end

@implementation KNWThemeValue (Convenient)

+ (id)array:(NSArray *)array
{
    return [self valueWithValues:array];
}

+ (id)dictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithValuesByTheme:dictionary];
}

+ (id)values:(NSObject *)first, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list list;
    va_start(list, first);
    
    NSMutableArray
    *objects = [[NSMutableArray alloc] initWithObjects:first, nil];
    NSObject
    *object = nil;
    while ((object = va_arg(list, NSObject *))) {
        [objects addObject:object];
    }
    
    va_end(list);
    
    return [self valueWithValues:objects];
}

@end
