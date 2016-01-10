//
//  NSInvocation+KNWTheme.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KNWThemeContext;

@interface NSInvocation (KNWTheme)

- (instancetype)knw_methodArgumentsCopy;
- (void)knw_invokeWithTarget:(id)target
                themeContext:(KNWThemeContext *)context;
- (instancetype)knw_invocationBySettingArgumentsWithContext:(KNWThemeContext *)context
                                      targetMethodSignature:(NSMethodSignature *)signature;

@end
