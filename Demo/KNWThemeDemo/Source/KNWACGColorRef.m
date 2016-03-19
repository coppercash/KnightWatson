//
//  KNWACGColorRef.m
//  KNWThemeDemo
//
//  Created by William on 3/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWACGColorRef.h"
#import <KnightWatson/KNWThemeContext.h>
#import <CoreGraphics/CGColor.h>
#import <UIKit/UIColor.h>

@implementation KNWACGColorRef

- (instancetype)initWithColorsByTheme:(NSDictionary *)colors {
    if (self = [super init]) {
        _colorsByTheme = colors;
    }
    return self;
}

- (void)knw_invocation:(NSInvocation *)invocation
    setArgumentAtIndex:(NSUInteger)index
      withThemeContext:(KNWThemeContext *)context
{
    CGColorRef
    color = _colorsByTheme[context.theme].CGColor;
    [invocation setArgument:&color
                    atIndex:index];
}

@end
