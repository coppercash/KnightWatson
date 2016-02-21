//
//  KNWThemedArgument.m
//  KNWTheme
//
//  Created by William on 2/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWThemedArgument.h"
#import "KNWThemeContext.h"
#import "NSInvocation+KNWTheme.h"

@implementation KNWThemedArgument

- (instancetype)initWithValuesByTheme:(NSDictionary *)values
{
    if (self = [super init]) {
        _valuesByTheme = values.copy;
    }
    return self;
}

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    NSParameterAssert(context);
    
    return _valuesByTheme[context.theme];
}

- (void)knw_invocation:(NSInvocation *)invocation
  setArgumentAtIndex:(NSUInteger)index
    withThemeContext:(KNWThemeContext *)context
{
    NSParameterAssert(invocation);
    NSParameterAssert(context);
    NSParameterAssert(index < invocation.methodSignature.numberOfArguments);

    id
    value = _valuesByTheme[context.theme];
    char const
    *type = [invocation.methodSignature getArgumentTypeAtIndex:index];
    
    // Passed value is boxed in NSValue of the same type.
    //
    if ([value isKindOfClass:NSValue.class] &&
        (0 == strcmp(type, [(NSValue *)value objCType]))) {
        [invocation knw_setValueArguement:value
                                  atIndex:index];
    }
    
    // Passed value is boxed in NSNumber.
    //
    else if ([value isKindOfClass:NSNumber.class]) {
        [invocation knw_setNumberAugument:value
                                  atIndex:index
                                   ofType:type];
    }
    else {
        @throw
        [NSException exceptionWithName:@"KNWThemedArgumentUnboxException"
                                reason:
         [NSString stringWithFormat:@
          "This example class can only hanle argument boxed in NSValue and NSNumber, "
          "but your value is boxed in %@. "
          "Thus, please implement your own box class conforms to protocol %@.",
          [value class],
          NSStringFromProtocol(@protocol(KNWNonObjectArgument))]
                              userInfo:nil];
    }
}

@end

@implementation KNWThemedArgument (Convenient)

+ (id)array:(NSArray *)array
{
    NSMutableDictionary
    *collector = [[NSMutableDictionary alloc] initWithCapacity:array.count];
    for (NSUInteger index = 0; index < array.count; index++) {
        collector[@(index)] = array[index];
    }

    return [[self alloc] initWithValuesByTheme:collector];
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
    
    return [self array:objects];
}

@end
