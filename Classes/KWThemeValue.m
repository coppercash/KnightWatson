//
//  KWThemeValue.m
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import "KWThemeValue.h"

@implementation KWThemeValue
@synthesize valuesByTheme = _valuesByTheme;

- (instancetype)initWithValuesByTheme:(NSDictionary *)values {
    if (self = [super init]) {
        _valuesByTheme = values;
    }
    return self;
}

@end
