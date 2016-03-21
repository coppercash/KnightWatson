//
//  ViewController.m
//  KNWThemeDemo
//
//  Created by William on 3/5/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "ViewController.h"

#import "KNWThemeContext+Demo.h"
#import "NSLayoutConstraint+Convenient.h"
#import "UIColor+LightAndDark.h"
#import "UIColor+Hex.h"
#import "NSValue+KNWTheme.h"

#import "KNWACGColorRef.h"
#import "KNWAUIImage.h"

#import <KnightWatson/KnightWatson.h>
#import <PNChart/PNChart.h>

CGFloat
sDefaultFontSize = 13.;

@interface ViewController ()

@end

@interface ViewController (UICollectionView) <
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _margin = 20.;
        _numberOfColumns = 2;
        _themes = @[KNWDTheme.system,
                    KNWDTheme.daylight,
                    KNWDTheme.night,
                    KNWDTheme.lawn,];
    }
    return self;
}

- (void)loadView
{
    UICollectionViewFlowLayout
    *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView
    *view = [[UICollectionView alloc] initWithFrame:UIScreen.mainScreen.bounds
                               collectionViewLayout:layout];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UICollectionView
    *view = (UICollectionView *)self.view;
    view.backgroundColor = UIColor.whiteColor;
    view.delegate = self;
    view.dataSource = self;
    
    NSDictionary
    *cellsByReuseID =
    @{@(KNWDCellLabel).stringValue: KNWDLabelCell.class,
      @(KNWDCellButton).stringValue: KNWDButtonCell.class,
      @(KNWDCellImage).stringValue: KNWDImageCell.class,
      @(KNWDCellLayer).stringValue: KNWDLayerCell.class,
      @(KNWDCellChart).stringValue: KNWDChartCell.class,};
    for (NSString *reuseID in cellsByReuseID) {
        [view registerClass:cellsByReuseID[reuseID]
 forCellWithReuseIdentifier:reuseID];
    }
    
    UICollectionViewFlowLayout
    *layout = (UICollectionViewFlowLayout *)view.collectionViewLayout;
    layout.minimumInteritemSpacing =
    layout.minimumLineSpacing =
    _margin;
    layout.sectionInset = UIEdgeInsetsMake(_margin, _margin, _margin, _margin);
    
    // Navigation Bar
    //
    UISegmentedControl
    *segment = [[UISegmentedControl alloc] initWithItems:_themes];
    [segment addTarget:self
                action:@selector(handleSegmentValueChanged:)
      forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = [_themes indexOfObject:KNWThemeContext.defaultThemeContext.theme];
    self.navigationItem.titleView = segment;
    
    UINavigationBar
    *navBar = self.navigationController.navigationBar;
    navBar.knw_themable.barTintColor = (id)
    @{KNWDTheme.system: [UIColor colorWithRed:(247.0f/255.0f) green:(247.0f/255.0f) blue:(247.0f/255.0f) alpha:1],
      KNWDTheme.daylight: [UIColor colorWithHex:0xacf0f2],
      KNWDTheme.night: [UIColor colorWithHex:0x002f2f],
      KNWDTheme.lawn: [UIColor colorWithHex:0x00a388],};
    navBar.knw_themable.tintColor = (id)
    @{KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
      KNWDTheme.night: [UIColor colorWithHex:0xefecca],
      KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSegmentValueChanged:(UISegmentedControl *)segment
{
    [UIView transitionWithView:UIApplication.sharedApplication.delegate.window
                      duration:.5
                       options:(UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent)
                    animations:^{
                        KNWThemeContext.defaultThemeContext.theme = _themes[segment.selectedSegmentIndex];
                    } completion:nil];
}

@end

@implementation ViewController (UICollectionView)

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return
    [collectionView dequeueReusableCellWithReuseIdentifier:@(indexPath.row).stringValue
                                              forIndexPath:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return KNWDCellCount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat
    width = (collectionView.bounds.size.width - (_numberOfColumns + 1) * _margin) / _numberOfColumns;
    return CGSizeMake(width, width);
}

@end

@implementation KNWDBaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.knw_themable.backgroundColor = (id)
        @{KNWDTheme.system: [UIColor colorWithRed:(247.0f/255.0f) green:(247.0f/255.0f) blue:(247.0f/255.0f) alpha:1],
          KNWDTheme.daylight: [UIColor colorWithHex:0xacf0f2],
          KNWDTheme.night: [UIColor colorWithHex:0x002f2f],
          KNWDTheme.lawn: [UIColor colorWithHex:0x00a388],};
    }
    return self;
}

@end

@implementation KNWDLabelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView
        *superview = self.contentView;
        
        UILabel
        *label = [[UILabel alloc] initWithFrame:superview.bounds];
        label.numberOfLines = 2;
        
        CGFloat
        fontSize = sDefaultFontSize;
        NSDictionary
        *fontsByTheme =
        @{KNWDTheme.system: [UIFont systemFontOfSize:fontSize],
          KNWDTheme.daylight: [UIFont boldSystemFontOfSize:fontSize],
          KNWDTheme.night: [UIFont italicSystemFontOfSize:fontSize],
          KNWDTheme.lawn: [UIFont systemFontOfSize:fontSize]},
        *textColorsByTheme =
        @{KNWDTheme.system: self.tintColor,
          KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
          KNWDTheme.night: [UIColor colorWithHex:0xefecca],
          KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],};
        
        NSMutableDictionary<NSString *, NSAttributedString *>
        *stringsByTheme = [[NSMutableDictionary alloc] initWithCapacity:fontsByTheme.count];
        for (NSString *theme in fontsByTheme.allKeys) {
            UIColor
            *textColor = textColorsByTheme[theme],
            *highlightColor = textColor.darkerColor.darkerColor.darkerColor;
            UIFont
            *font = fontsByTheme[theme];
            NSDictionary
            *attributes = @{NSForegroundColorAttributeName: textColor,
                            NSFontAttributeName: [UIFont systemFontOfSize:fontSize],},
            *hightlightAttrs = @{NSForegroundColorAttributeName: highlightColor,
                                 NSFontAttributeName: font,};
            NSMutableAttributedString
            *string = [[NSMutableAttributedString alloc] initWithString:@"UILabel\n#setAttributedString:"
                                                             attributes:attributes];
            [string setAttributes:hightlightAttrs
                            range:NSMakeRange(2, 5)];
            [string setAttributes:hightlightAttrs
                            range:NSMakeRange(12, 16)];
            stringsByTheme[theme] = string;
        }
        
        label.knw_themable.attributedText = (id)stringsByTheme;
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [superview addSubview:label];
        [superview addConstraints:
         [NSLayoutConstraint constraintsByAligningCenterOfView:label
                                                     otherView:superview]];
    }
    return self;
}

@end

@implementation KNWDButtonCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView
        *superview = self.contentView;
        
        UIButton
        *button = [[UIButton alloc] init];
        [button setTitle:@"UIButton\n#setTitleColor:\n         forState:"
                forState:UIControlStateNormal];
        button.titleLabel.numberOfLines = 3;
        button.titleLabel.font = [UIFont systemFontOfSize:sDefaultFontSize];
        button.contentEdgeInsets = UIEdgeInsetsMake(5., 5., 5., 5.);
        [button.knw_themable setTitleColor:(id)@{KNWDTheme.system: self.tintColor,
                                                 KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
                                                 KNWDTheme.night: [UIColor colorWithHex:0xefecca],
                                                 KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],}
                                  forState:UIControlStateNormal];
        
        CALayer
        *layer = button.layer;
        layer.cornerRadius = 10.;
        layer.borderWidth = 1.;
        [layer
         .knw_themable
         .argAtIndex(0, [[KNWACGColorRef alloc] initWithColorsByTheme:
                         @{KNWDTheme.system: self.tintColor,
                           KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
                           KNWDTheme.night: [UIColor colorWithHex:0xefecca],
                           KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],}])
         setBorderColor:NULL];
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [superview addSubview:button];
        [superview addConstraints:
         [NSLayoutConstraint constraintsByAligningCenterOfView:button
                                                     otherView:superview]];
    }
    return self;
}

@end

@implementation KNWDImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView
        *superview = self.contentView;
        
        UIImageView
        *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        image.knw_themable.image = [(id)[KNWAUIImage alloc] initWithImageNamesByTheme:
                                    @{KNWDTheme.system: @"iphone",
                                      KNWDTheme.daylight: @"sun",
                                      KNWDTheme.night: @"moon",
                                      KNWDTheme.lawn: @"lawn",}];
        
        image.translatesAutoresizingMaskIntoConstraints = NO;
        [superview addSubview:image];
        [superview addConstraints:
         [NSLayoutConstraint constraintsByAligningCenterOfView:image
                                                     otherView:superview]];
        [superview addConstraints:
         [NSLayoutConstraint constraintsByZoomingView:image
                                            otherView:superview
                                              byScale:1.]];
        
        UILabel
        *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:sDefaultFontSize];
        label.text = @"UIImageView\n#setImage:";
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithWhite:1.
                                                  alpha:0.5];
        label.knw_themable.textColor = (id)
        @{KNWDTheme.system: self.tintColor,
          KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
          KNWDTheme.night: [UIColor colorWithHex:0xefecca],
          KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],};
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [superview addSubview:label];
        [superview addConstraints:
         @[
           [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superview attribute:NSLayoutAttributeWidth
                                       multiplier:1. constant:0.],
           [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superview attribute:NSLayoutAttributeCenterX
                                       multiplier:1. constant:0.],
           [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superview attribute:NSLayoutAttributeBottom
                                       multiplier:1. constant:0.],
           [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superview attribute:NSLayoutAttributeHeight
                                       multiplier:(1 - 0.618) constant:0.],
           ]];
    }
    return self;
}

@end

@implementation KNWDLayerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView
        *superview = self.contentView;
        
        UILabel
        *label = [[UILabel alloc] init];
        label.text = @"CALayer\n#setShadowColor:\n(non-object param)";
        label.numberOfLines = 3;
        label.font = [UIFont systemFontOfSize:sDefaultFontSize];
        label.knw_themable.textColor = (id)
        @{KNWDTheme.system: self.tintColor,
          KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
          KNWDTheme.night: [UIColor colorWithHex:0xefecca],
          KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],};
        
        CALayer
        *layer = label.layer;
        layer.shadowOpacity = 1.;
        [layer
         .knw_themable
         .argAtIndex(0, [[KNWACGColorRef alloc] initWithColorsByTheme:
                         @{KNWDTheme.system: self.tintColor,
                           KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
                           KNWDTheme.night: [UIColor colorWithHex:0xefecca],
                           KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],}])
         setShadowColor:NULL];
        
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [superview addSubview:label];
        [superview addConstraints:
         [NSLayoutConstraint constraintsByAligningCenterOfView:label
                                                     otherView:superview]];
    }
    return self;
}

@end

@implementation KNWDChartCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView
        *superview = self.contentView;
        
        NSArray<PNPieChartDataItem *>
        *items =
        @[[PNPieChartDataItem dataItemWithValue:16 color:nil description:@"Any"],
          [PNPieChartDataItem dataItemWithValue:40 color:nil description:@"Method"],
          [PNPieChartDataItem dataItemWithValue:20 color:nil description:@"You"],
          [PNPieChartDataItem dataItemWithValue:24 color:nil description:@"Want"],];
        PNPieChart
        *pieChart = [[PNPieChart alloc] initWithFrame:CGRectZero
                                                items:items];
        pieChart.descriptionTextColor = [UIColor whiteColor];
        pieChart.descriptionTextFont  = [UIFont systemFontOfSize:sDefaultFontSize];
        pieChart.displayAnimated = NO;
        pieChart.hideValues = YES;
        
        pieChart.translatesAutoresizingMaskIntoConstraints = NO;
        [superview addSubview:pieChart];
        [superview addConstraints:
         [NSLayoutConstraint constraintsByAligningCenterOfView:pieChart
                                                     otherView:superview]];
        [superview addConstraints:
         [NSLayoutConstraint constraintsByZoomingView:pieChart
                                            otherView:superview
                                              byScale:0.85]];
        
        NSDictionary
        *baseColors = @{KNWDTheme.system: self.tintColor,
                        KNWDTheme.daylight: [UIColor colorWithHex:0xeb7f00],
                        KNWDTheme.night: [UIColor colorWithHex:0xefecca],
                        KNWDTheme.lawn: [UIColor colorWithHex:0xffff9d],};
        [items enumerateObjectsUsingBlock:^(PNPieChartDataItem *obj, NSUInteger idx, BOOL *stop) {
            NSMutableDictionary
            *colorsByTheme = [[NSMutableDictionary alloc] initWithCapacity:baseColors.count];
            for (NSString *theme in baseColors.allKeys) {
                UIColor
                *color = baseColors[theme];
                for (NSUInteger index = 0; index < idx; index++) {
                    color = color.darkerColor;
                }
                colorsByTheme[theme] = color;
            }
            obj.knw_themable.color = (id)colorsByTheme;
        }];
        
        [pieChart.knw_themable strokeChart];
    }
    return self;
}

@end
