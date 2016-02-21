//
//  NSArray+KNWObjectArgument.m
//  KNWTheme
//
//  Created by William on 2/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "NSArray+KNWObjectArgument.h"

@implementation NSArray (KNWObjectArgument)

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    return self[[(NSNumber *)context.theme unsignedIntegerValue]];
}

@end
