//
//  KNWThemeContext+Demo.m
//  KNWThemeDemo
//
//  Created by William on 3/19/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWThemeContext+Demo.h"

@implementation KNWThemeContext (Demo)

+ (void)initialize
{
    [self.defaultThemeContext setTheme:KNWDTheme.system];
}

@end

const struct KNWDTheme KNWDTheme = {
    .system = @"System",
    .daylight = @"Daylight",
    .night = @"Night",
    .lawn = @"Lawn",
};
