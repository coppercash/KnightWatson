//
//  NSInvocation+KNWTheme.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSInvocation+KNWTheme.h"

#import "KNWThemableValue.h"
#import "KNWThemeContext.h"

@implementation NSInvocation (KNWTheme)

- (void)knw_invokeWithTarget:(id)target
                themeContext:(KNWThemeContext *)context
{
    NSMethodSignature
    *signature = self.methodSignature;
    for (NSUInteger index = 2; index < signature.numberOfArguments; index++) {
        char const
        *type = [signature getArgumentTypeAtIndex:index];
        if (0 != strcmp("@", type)) { continue; }
        
        id __unsafe_unretained
        argument;
        [self getArgument:&argument
                  atIndex:index];
        if (NO == [argument conformsToProtocol:@protocol(KNWThemableValue)]) { continue; }
        
        id
        value = [argument respondsToSelector:@selector(knw_valueWithThemeContext:)] ?
        [(id<KNWThemableValue>)argument knw_valueWithThemeContext:context] :
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [(id<KNWThemableValue>)argument knw_valueByTheme:context.theme];
#pragma clang diagnostic pop
        [self setArgument:&value
                  atIndex:index];
    }
    
    [self invokeWithTarget:target];
}

- (instancetype)knw_methodArgumentsCopy
{
    NSInvocation __unsafe_unretained
    *invocation = self;
    NSParameterAssert(invocation);
    
    NSMethodSignature __unsafe_unretained
    *signature = invocation.methodSignature;
    NSInvocation
    *copied = [NSInvocation invocationWithMethodSignature:signature];
    copied.selector = self.selector;
    
    for (NSUInteger index = 2; index < signature.numberOfArguments; index++) {
        char const
        *type = [signature getArgumentTypeAtIndex:index];
        NSUInteger
        bufferSize = 0;
        NSGetSizeAndAlignment(type, &bufferSize, NULL);
        void
        *buffer = malloc(bufferSize);
        [invocation getArgument:buffer
                        atIndex:index];
        [copied setArgument:buffer
                    atIndex:index];
        free(buffer);
    }
    
    return copied;
}

- (instancetype)knw_invocationBySettingArgumentsWithContext:(KNWThemeContext *)context
                                      targetMethodSignature:(NSMethodSignature *)restoredSignature
{
    NSInvocation
    *themedInvocation = self;
    NSMethodSignature
    *themedSignature = self.methodSignature;
    NSParameterAssert(themedInvocation);
    NSParameterAssert(themedSignature);
    NSParameterAssert(restoredSignature);
    NSParameterAssert(context);
    NSAssert(themedSignature.numberOfArguments == restoredSignature.numberOfArguments,
             @"Can't retore invocation from another one with different number of arguments.");
    
    NSInvocation
    *restoredInvocation = [NSInvocation invocationWithMethodSignature:restoredSignature];
    restoredInvocation.selector = themedInvocation.selector;
    
    for (NSUInteger index = 2; index < restoredSignature.numberOfArguments; index++) {
        char const
        *wantedType = [restoredSignature getArgumentTypeAtIndex:index],
        *passedType = [themedSignature getArgumentTypeAtIndex:index];
        
        if (0 == strcmp(@encode(id), passedType)) {
            id __unsafe_unretained passedArgument;
            [themedInvocation getArgument:&passedArgument
                                  atIndex:index];
            
            // An object passed, and a value of the same type wanted.
            //
            if (0 == strcmp(@encode(id), wantedType)) {
                
                // The passed value is themed, restore it.
                //
                if ([passedArgument conformsToProtocol:@protocol(KNWThemableObject)]) {
                    id
                    restoredArgument = [(id<KNWThemableObject>)passedArgument knw_valueWithThemeContext:context];
                    [restoredInvocation setArgument:&restoredArgument
                                            atIndex:index];
                }
                
                // The passed value is not themed, copy it as object directly.
                //
                else {
                    [restoredInvocation setArgument:&passedArgument
                                            atIndex:index];
                }
            }
            
            // An object passed (must be themed), and a non-object wanted.
            //
            else {
                
                // The passed value can de-box the object value by itself.
                //
                if ([passedArgument conformsToProtocol:@protocol(KNWThemableNonObject)]) {
                    [(id<KNWThemableNonObject>)passedArgument knw_invocation:restoredInvocation
                                                          setArgumentAtIndex:index
                                                            withThemeContext:context];
                }
                
                // The passed value can't de-box by itself, we try to do it by asserting its class
                //
                else if ([passedArgument conformsToProtocol:@protocol(KNWThemableObject)]) {
                    id
                    restoredArgument = [(id<KNWThemableObject>)passedArgument knw_valueWithThemeContext:context];
                    
                    // Passed value is boxed in NSValue of the same type.
                    //
                    if ([restoredArgument isKindOfClass:NSValue.class] &&
                        (0 == strcmp(wantedType, [(NSValue *)restoredArgument objCType]))) {
                        NSUInteger
                        bufferSize = 0;
                        NSGetSizeAndAlignment(wantedType, &bufferSize, NULL);
                        void
                        *buffer = malloc(bufferSize);
                        [(NSValue *)restoredArgument getValue:buffer];
                        [restoredInvocation setArgument:buffer
                                                atIndex:index];
                        free(buffer);
                    }
                    else if ([restoredArgument isKindOfClass:NSNumber.class]) {
                        [restoredInvocation knw_setNumberAugument:restoredArgument
                                                          atIndex:index
                                                           ofType:wantedType];
                    }
                    else {
                        @throw [NSException exceptionWithName:@"KNWUnthemedNonObjectArgument"
                                                       reason:
                                [NSString stringWithFormat:@
                                 "Augument of type '%s' is passed as '%@', "
                                 "which can't be de-boxed automatically.",
                                 wantedType,
                                 [passedArgument class]]
                                                     userInfo:nil];
                    }
                }
                
                // It is not themed, something must be wrong!
                //
                else {
                    @throw [NSException exceptionWithName:@"KNWUnthemedNonObjectArgument"
                                                   reason:@"A non-object argument passed as an object must be themed."
                                                 userInfo:nil];
                }
            }
        }
        
        // A non-object passed, and a value of the same type wanted
        //
        else if (0 == strcmp(wantedType, passedType)) {
            NSUInteger
            bufferSize = 0;
            NSGetSizeAndAlignment(wantedType, &bufferSize, NULL);
            void
            *buffer = malloc(bufferSize);
            [themedInvocation getArgument:buffer
                                  atIndex:index];
            [restoredInvocation setArgument:buffer
                                    atIndex:index];
            free(buffer);
        }
        
        // A non-object passed, but an object wanted
        //
        else {
            @throw [NSException exceptionWithName:@"KNWUnresolvedArgumentType"
                                           reason:@"An object argument can't be passed as non-object."
                                         userInfo:nil];
        }
    }
    
    // TODO: If the invocation needed to be retained
    //
    [restoredInvocation retainArguments];
    return restoredInvocation;
}

- (void)knw_setNumberAugument:(NSNumber *)number
                     atIndex:(NSUInteger)index
                      ofType:(char const *)wantedType
{
    NSInvocation
    *restoredInvocation = self;
    NSParameterAssert([number isKindOfClass:NSNumber.class]);
    NSParameterAssert(restoredInvocation);
    NSParameterAssert(index < restoredInvocation.methodSignature.numberOfArguments);
    
    switch (wantedType[0]) {
        case 'c': {
            char
            value = number.charValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'i': {
            int
            value = number.intValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 's': {
            short
            value = number.shortValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'l': {
            long
            value = number.longValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'q': {
            long long
            value = number.longLongValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'C': {
            unsigned char
            value = number.unsignedCharValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'I': {
            unsigned int
            value = number.unsignedIntValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'S': {
            unsigned short
            value = number.unsignedShortValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'L': {
            unsigned long
            value = number.unsignedLongValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'Q': {
            unsigned long long
            value = number.unsignedLongLongValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'f': {
            float
            value = number.floatValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'd': {
            double
            value = number.doubleValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'B': {
            bool
            value = number.boolValue;
            [restoredInvocation setArgument:&value
                                    atIndex:index] ;
        } break;
        default:
            @throw [NSException exceptionWithName:@"KNWUnresolvedNumber"
                                           reason:
                    [NSString stringWithFormat:@
                     "Augument of type '%s' is passed as '%@' of type '%s', "
                     "which can't be de-boxed automatically.",
                     wantedType,
                     number.class,
                     number.objCType]
                                         userInfo:nil];
            
            break;
    }
}

- (instancetype)knw_invocationBySubstitutingArguments:(NSDictionary *)arguments
                                         themeContext:(KNWThemeContext *)context
{
    NSInvocation __unsafe_unretained
    *themedInvocation = self;
    NSParameterAssert(context);
    NSParameterAssert(themedInvocation);

    NSMethodSignature
    *signature = themedInvocation.methodSignature;
    NSInvocation
    *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = themedInvocation.selector;

    NSUInteger const static
    argBase = 2;
    for (NSUInteger index = argBase; index < signature.numberOfArguments; index++) {
        // Get argument value
        //
        char const
        *type = [signature getArgumentTypeAtIndex:index];
        if (0 == strcmp(@encode(id), type)) {
            id __unsafe_unretained
            passed = arguments[@(index)];
            if (nil == passed) {
                [themedInvocation getArgument:&passed
                                      atIndex:index];
            }
            
            id
            restored = [passed conformsToProtocol:@protocol(KNWThemableObject)] ?
            [(id<KNWThemableObject>)passed knw_valueWithThemeContext:context] :
            passed;
            
            [invocation setArgument:&restored
                            atIndex:index];
        }
        else {
            id __unsafe_unretained
            substitution = arguments[@(index - argBase)];
            if (substitution) {
                if ([substitution conformsToProtocol:@protocol(KNWThemableNonObject)]) {
                    [(id<KNWThemableNonObject>)substitution knw_invocation:invocation
                                                        setArgumentAtIndex:index
                                                          withThemeContext:context];
                }
                else if ([substitution conformsToProtocol:@protocol(KNWThemableObject)]) {
                    id
                    restored = [(id<KNWThemableObject>)substitution knw_valueWithThemeContext:context];
                    
                    // Passed value is boxed in NSValue of the same type.
                    //
                    if ([restored isKindOfClass:NSValue.class] &&
                        (0 == strcmp(type, [(NSValue *)restored objCType]))) {
                        NSUInteger
                        bufferSize = 0;
                        NSGetSizeAndAlignment(type, &bufferSize, NULL);
                        void
                        *buffer = malloc(bufferSize);
                        [(NSValue *)restored getValue:buffer];
                        [invocation setArgument:buffer
                                        atIndex:index];
                        free(buffer);
                    }
                    
                    // Passed value is boxed in NSNumber.
                    //
                    else if ([restored isKindOfClass:NSNumber.class]) {
                        [invocation knw_setNumberAugument:restored
                                                  atIndex:index
                                                   ofType:type];
                    }
                    else {
                        @throw
                        [NSException exceptionWithName:@"KNWDeBoxArugmentException"
                                                reason:
                         [NSString stringWithFormat:@
                          "Augument of type '%s' is passed as '%@', "
                          "which can't be de-boxed automatically.",
                          type,
                          [restored class]]
                                              userInfo:nil];
                    }
                }
                else {
                    @throw
                    [NSException exceptionWithName:@"KNWDeThemeArugmentException"
                                            reason:
                     [NSString stringWithFormat:@
                      "Augument of type '%s' is passed as '%@', "
                      "which can't be de-theme."
                      "Please make it conforms to protocol %@ or %@.",
                      type,
                      [substitution class],
                      @protocol(KNWThemableNonObject),
                      @protocol(KNWThemableObject)]
                                          userInfo:nil];

                }
            }
            else {
                NSUInteger
                bufferSize = 0;
                NSGetSizeAndAlignment(type, &bufferSize, NULL);
                void
                *buffer = malloc(bufferSize);
                [themedInvocation getArgument:buffer
                                      atIndex:index];
                [invocation setArgument:buffer
                                atIndex:index];
                free(buffer);
            }
        }
    }
    
    return invocation;
}

@end
