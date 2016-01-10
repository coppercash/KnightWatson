//
//  KNWThemableValue.h
//  KNWTheme
//
//  Created by William on 1/9/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KNWThemeContext;



@protocol KNWThemableObject <NSObject>
- (id)knw_valueWithThemeContext:(KNWThemeContext *)context;
@end

@protocol KNWThemableNonObject <NSObject>
- (id)knw_invocation:(NSInvocation *)invocation
  setArgumentAtIndex:(NSUInteger)index
    withThemeContext:(KNWThemeContext *)context;
@end

@protocol KNWThemableValue <KNWThemableObject>
@optional
- (id)knw_valueByTheme:(id)theme __attribute__((deprecated));
@required
- (id)knw_valueWithThemeContext:(KNWThemeContext *)context;
@end

@interface NSDictionary (KNWThemableValue) <KNWThemableValue>
@end

@interface NSArray (KNWThemableValue) <KNWThemableValue>
@end
