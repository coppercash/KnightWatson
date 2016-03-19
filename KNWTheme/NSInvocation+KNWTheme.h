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

- (instancetype)knw_invocationBySubstitutingArguments:(NSDictionary *)arguments
                                         themeContext:(KNWThemeContext *)context;

- (void)knw_setValueArguement:(NSValue *)value
                      atIndex:(NSUInteger)index;

- (void)knw_setNumberAugument:(NSNumber *)number
                      atIndex:(NSUInteger)index
                       ofType:(char const *)wantedType;

@end
