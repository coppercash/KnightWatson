//
//  KNWAUIImage.h
//  KNWThemeDemo
//
//  Created by William on 3/19/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "KNWArgument.h"

@interface KNWAUIImage : NSObject <KNWObjectArgument>

@property (strong, readonly, nonatomic) NSDictionary<id, NSString *> *imageNamesByTheme;
- (instancetype)initWithImageNamesByTheme:(NSDictionary *)names;

@end
