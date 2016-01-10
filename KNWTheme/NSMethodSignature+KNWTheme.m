//
//  NSMethodSignature+KNWTheme.m
//  KNWTheme
//
//  Created by William on 1/16/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "NSMethodSignature+KNWTheme.h"

@implementation NSMethodSignature (KNWTheme)

- (instancetype)knw_methodSignatureBySubstitutingObjectArguments
{
    NSMethodSignature
    *original = self;
    NSParameterAssert(original);
    
    NSStringEncoding static const
    encoding = NSASCIIStringEncoding;
    NSMutableString
    *types = [[NSMutableString alloc] initWithString:[[NSString alloc] initWithCString:original.methodReturnType
                                                                              encoding:encoding]];
    for (int index = 0; index < original.numberOfArguments; index++) {
        NSString
        *type = [[NSString alloc] initWithCString:(index < 2 ? [original getArgumentTypeAtIndex:index] : @encode(id))
                                         encoding:encoding];
        [types appendString:type];
    }
    
    return [NSMethodSignature signatureWithObjCTypes:[types cStringUsingEncoding:encoding]];
}

@end
