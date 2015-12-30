//
//  KNWThemeValue.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNWThemeValue : NSObject {
    NSDictionary
    *_valuesByTheme;
}

@property (readonly) NSDictionary *valuesByTheme;
- (instancetype)initWithValuesByTheme:(NSDictionary *)values;
+ (instancetype)valueWithValues:(NSArray *)values;

@end

@interface KNWThemeValue (Convenient)

+ (id)array:(NSArray *)array;
+ (id)dictionary:(NSDictionary *)dictionary;
+ (id)values:(NSObject *)first, ... NS_REQUIRES_NIL_TERMINATION;

@end
