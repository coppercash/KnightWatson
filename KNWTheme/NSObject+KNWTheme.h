//
//  NSObject+KNWTheme.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KNWTheme)

- (instancetype)knw_themed;
- (instancetype)knw_themable;

@end

@protocol KNWThemablyInvoking <NSObject>

- (instancetype)substituteArgumentsByIndex:(NSDictionary *)argsByIndex;
- (instancetype(^)(NSDictionary *))argsByIndex;

- (instancetype)setKeepThemable:(BOOL)keep;
- (instancetype(^)(BOOL keep))keepThemable;

@end

@interface NSObject (KNWThemablyInvoking) <KNWThemablyInvoking>
@end
