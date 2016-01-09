//
//  KNWThemableValue.h
//  KNWTheme
//
//  Created by William on 1/9/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KNWThemableValue <NSObject>
@required
- (id)knw_valueByTheme:(id)theme;
@end

@interface NSDictionary (KNWThemableValue) <KNWThemableValue>
@end

@interface NSArray (KNWThemableValue) <KNWThemableValue>
@end
