//
//  UIColor+Hex.h
//  KNWThemeDemo
//
//  Created by William on 3/20/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(uint32_t)hex;

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

@end
