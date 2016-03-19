//
//  KNWArgument.h
//  KNWTheme
//
//  Created by William on 2/21/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KNWThemeContext;

@protocol KNWObjectArgument <NSObject>
- (id)knw_valueWithThemeContext:(KNWThemeContext *)context;
@end

@protocol KNWNonObjectArgument <NSObject>
- (void)knw_invocation:(NSInvocation *)invocation
    setArgumentAtIndex:(NSUInteger)index
      withThemeContext:(KNWThemeContext *)context;
@end
