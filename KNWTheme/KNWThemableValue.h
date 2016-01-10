//
//  KNWThemableValue.h
//  KNWTheme
//
//  Created by William on 1/9/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KNWThemeContext;

@protocol KNWThemableValue <NSObject>
@optional
- (id)knw_valueByTheme:(id)theme __attribute__((deprecated));
@required
- (id)knw_valueWithThemeContext:(KNWThemeContext *)context;
@end

@interface NSDictionary (KNWThemableValue) <KNWThemableValue>
@end

@interface NSArray (KNWThemableValue) <KNWThemableValue>
@end
