//
//  KWThemeValue.h
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWThemeValue : NSObject {
    NSDictionary
    *_valuesByTheme;
}

@property (readonly) NSDictionary *valuesByTheme;
- (instancetype)initWithValuesByTheme:(NSDictionary *)values;

@end
