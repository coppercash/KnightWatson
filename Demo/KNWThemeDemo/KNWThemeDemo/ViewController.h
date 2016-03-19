//
//  ViewController.h
//  KNWThemeDemo
//
//  Created by William on 3/5/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KNWDCell) {
    KNWDCellButton,
    KNWDCellImage,
    KNWDCellLabel,
    KNWDCellLayer,
    KNWDCellChart,
    
    KNWDCellCount,
};

@interface ViewController : UIViewController
{
    @protected
    CGFloat
    _margin;
    NSUInteger
    _numberOfColumns;
    NSArray
    *_themes;
}

@end

@interface KNWDBaseCell : UICollectionViewCell
@end

@interface KNWDLabelCell : KNWDBaseCell
@end

@interface KNWDButtonCell : KNWDBaseCell
@end

@interface KNWDImageCell : KNWDBaseCell
@end

@interface KNWDLayerCell : KNWDBaseCell
@end

@interface KNWDChartCell : KNWDBaseCell
@end
