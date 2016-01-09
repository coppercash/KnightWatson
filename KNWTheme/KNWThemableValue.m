//
//  KNWThemableValue.m
//  KNWTheme
//
//  Created by William on 1/9/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWThemableValue.h"

@implementation NSDictionary (KNWThemableValue)

- (id)knw_valueByTheme:(id)theme
{
    return self[theme];
}

@end

@implementation NSArray (KNWThemableValue)

- (id)knw_valueByTheme:(NSNumber *)theme
{
    return self[theme.unsignedIntegerValue];
}

@end
