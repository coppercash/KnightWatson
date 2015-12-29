//
//  KWThemeContext.m
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KWThemeContext.h"

@implementation KWThemeContext

+ (instancetype)sharedThemeContext
{
    KWThemeContext __block
    *_instance = nil;
    dispatch_once_t
    _predicate;
    dispatch_once(&_predicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)setTheme:(id<NSCopying>)theme
{
    _theme = theme;
}

@end
