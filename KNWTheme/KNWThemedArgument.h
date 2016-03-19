//
//  KNWThemedArgument.h
//  KNWTheme
//
//  Created by William on 2/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNWArgument.h"

@interface KNWThemedArgument : NSObject <KNWObjectArgument, KNWNonObjectArgument>
{
    NSDictionary
    *_valuesByTheme;
}

- (instancetype)initWithValuesByTheme:(NSDictionary *)values;

@end

@interface KNWThemedArgument (Convenient)

+ (id)array:(NSArray *)array;
+ (id)dictionary:(NSDictionary *)dictionary;
+ (id)values:(NSObject *)first, ... NS_REQUIRES_NIL_TERMINATION;

@end
