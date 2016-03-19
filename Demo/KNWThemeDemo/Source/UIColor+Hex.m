//
//  UIColor+Hex.m
//  KNWThemeDemo
//
//  Created by William on 3/20/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(uint32_t)hex {
    return [self colorWithHex:hex alpha:1.f];
}

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha
{
    CGFloat red   = (CGFloat) ((hex & 0xff0000) >> 16) / 255.0f;
    CGFloat green = (CGFloat) ((hex & 0x00ff00) >> 8)  / 255.0f;
    CGFloat blue  = (CGFloat)  (hex & 0x0000ff)        / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
