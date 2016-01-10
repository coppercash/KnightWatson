//
//  KNWThemableValue.m
//  KNWTheme
//
//  Created by William on 1/9/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWThemableValue.h"

#import "KNWThemeContext.h"

@implementation NSDictionary (KNWThemableValue)

- (id)knw_valueByTheme:(id)theme
{
    return self[theme];
}

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    return self[context.theme];
}

@end

@implementation NSArray (KNWThemableValue)

- (id)knw_valueByTheme:(NSNumber *)theme
{
    return self[theme.unsignedIntegerValue];
}

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    return self[[(NSNumber *)context.theme unsignedIntegerValue]];
}

@end
