//
//  KNWAUIImage.m
//  KNWThemeDemo
//
//  Created by William on 3/19/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWAUIImage.h"
#import <KnightWatson/KNWThemeContext.h>
#import <UIKit/UIImage.h>

@implementation KNWAUIImage

- (instancetype)initWithImageNamesByTheme:(NSDictionary *)names
{
    if (self = [super init]) {
        _imageNamesByTheme = names;
    }
    return self;
}

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    return [UIImage imageNamed:_imageNamesByTheme[context.theme]];
}

@end
