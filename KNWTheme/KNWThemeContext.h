//
//  KNWThemeContext.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNWThemeContext : NSObject {
    @private
    id
    _theme;
    NSHashTable
    *_themableObjects;
}

+ (instancetype)defaultThemeContext;

@property (nonatomic) id theme;

@end
