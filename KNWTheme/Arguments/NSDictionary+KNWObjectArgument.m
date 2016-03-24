//
//  NSDictionary+KNWObjectArgument.m
//  KNWTheme
//
//  Created by William on 2/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "NSDictionary+KNWObjectArgument.h"

#import "KNWThemeContext.h"

@implementation NSDictionary (KNWObjectArgument)

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    return self[context.theme];
}

@end
