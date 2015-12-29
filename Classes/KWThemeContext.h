//
//  KWThemeContext.h
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWThemeContext : NSObject {
    @private
    id<NSCopying>
    _theme;
}

+ (instancetype)sharedThemeContext;

@property (nonatomic) id<NSCopying> theme;

@end
