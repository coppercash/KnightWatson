//
//  KWThemableObjectProxy.h
//  KWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWThemableObjectProxy : NSProxy {
    NSObject __unsafe_unretained
    *_target;
}

- (instancetype)initWithTarget:(NSObject *)target;

@end
