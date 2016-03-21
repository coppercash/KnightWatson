//
//  NSValue+KNWTheme.h
//  KNWThemeDemo
//
//  Created by William on 3/20/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <Foundation/NSValue.h>
#import <CoreGraphics/CGColor.h>

@interface NSValue (KNWTheme)

+ (instancetype)knw_valueWithCGColorRef:(CGColorRef)colorRef;

@end
