//
//  KNWThemeContext+Demo.h
//  KNWThemeDemo
//
//  Created by William on 3/19/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <KnightWatson/KNWThemeContext.h>

@interface KNWThemeContext (Demo)
@end

extern const struct KNWDTheme {
    __unsafe_unretained NSString *system;
    __unsafe_unretained NSString *daylight;
    __unsafe_unretained NSString *night;
    __unsafe_unretained NSString *lawn;
} KNWDTheme;
