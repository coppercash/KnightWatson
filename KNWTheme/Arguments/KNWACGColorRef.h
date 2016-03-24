//
//  KNWACGColorRef.h
//  KNWThemeDemo
//
//  Created by William on 3/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWArgument.h"

@class UIColor;

@interface KNWACGColorRef : NSObject <KNWNonObjectArgument>

@property (readonly, strong, nonatomic) NSDictionary<id, UIColor *> *colorsByTheme;
- (instancetype)initWithColorsByTheme:(NSDictionary *)colors;

@end
