//
//  NSInvocation+KWTheme.h
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (KWTheme)

- (instancetype)kw_copy;
- (void)kw_invokeWithTarget:(id)target theme:(id<NSCopying>)theme;

@end
