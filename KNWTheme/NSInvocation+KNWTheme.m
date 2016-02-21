//
//  NSInvocation+KNWTheme.m
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "NSInvocation+KNWTheme.h"

#import "KNWArgument.h"
#import "KNWThemeContext.h"

@implementation NSInvocation (KNWTheme)

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
        
        // The argument is supposed to be an object
        //
        if (0 == strcmp(@encode(id), type)) {
            id __unsafe_unretained
            passed = arguments[@(index - argBase)];
            if (nil == passed) {
                [themedInvocation getArgument:&passed
                                      atIndex:index];
            }
            
            id
            restored = [passed conformsToProtocol:@protocol(KNWObjectArgument)] ?
            [(id<KNWObjectArgument>)passed knw_valueWithThemeContext:context] :
            passed;
            
            [invocation setArgument:&restored
                            atIndex:index];
        }
        
        // The argument is supposed no to be an object.
        //
        else {
            id __unsafe_unretained
            substitution = arguments[@(index - argBase)];
            
            // The argument is substituted. Perhaps for theming purpose.
            //
            if (substitution) {
                if ([substitution conformsToProtocol:@protocol(KNWNonObjectArgument)]) {
                    [(id<KNWNonObjectArgument>)substitution knw_invocation:invocation
                                                        setArgumentAtIndex:index
                                                          withThemeContext:context];
                }
                else if ([substitution conformsToProtocol:@protocol(KNWObjectArgument)]) {
                    id
                    restored = [(id<KNWObjectArgument>)substitution knw_valueWithThemeContext:context];
                    
                    // Passed value is boxed in NSValue of the same type.
                    //
                    if ([restored isKindOfClass:NSValue.class] &&
                        (0 == strcmp(type, [(NSValue *)restored objCType]))) {
                        [invocation knw_setValueArguement:restored
                                                  atIndex:index];
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
                      @protocol(KNWNonObjectArgument),
                      @protocol(KNWObjectArgument)]
                                          userInfo:nil];
                    
                }
            }
            
            // The arguement is not substituted. Must be passed plainly.
            //
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

- (void)knw_setValueArguement:(NSValue *)value
                      atIndex:(NSUInteger)index
{
    NSInvocation __unsafe_unretained
    *invocation = self;
    NSParameterAssert([value isKindOfClass:NSValue.class]);
    NSParameterAssert(index < invocation.methodSignature.numberOfArguments);
    NSParameterAssert(invocation);

    NSUInteger
    bufferSize = 0;
    NSGetSizeAndAlignment(value.objCType, &bufferSize, NULL);
    void
    *buffer = malloc(bufferSize);
    [value getValue:buffer];
    [invocation setArgument:buffer
                    atIndex:index];
    free(buffer);
}

- (void)knw_setNumberAugument:(NSNumber *)number
                      atIndex:(NSUInteger)index
                       ofType:(char const *)wantedType
{
    NSInvocation __unsafe_unretained
    *invocation = self;
    NSParameterAssert([number isKindOfClass:NSNumber.class]);
    NSParameterAssert(index < invocation.methodSignature.numberOfArguments);
    NSParameterAssert(invocation);
    
    switch (wantedType[0]) {
        case 'c': {
            char
            value = number.charValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'i': {
            int
            value = number.intValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 's': {
            short
            value = number.shortValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'l': {
            long
            value = number.longValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'q': {
            long long
            value = number.longLongValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'C': {
            unsigned char
            value = number.unsignedCharValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'I': {
            unsigned int
            value = number.unsignedIntValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'S': {
            unsigned short
            value = number.unsignedShortValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'L': {
            unsigned long
            value = number.unsignedLongValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'Q': {
            unsigned long long
            value = number.unsignedLongLongValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'f': {
            float
            value = number.floatValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'd': {
            double
            value = number.doubleValue;
            [invocation setArgument:&value
                                    atIndex:index] ;
        } break;
        case 'B': {
            bool
            value = number.boolValue;
            [invocation setArgument:&value
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

@end
