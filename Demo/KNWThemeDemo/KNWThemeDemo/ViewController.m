//
//  ViewController.m
//  KNWThemeDemo
//
//  Created by William on 3/5/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "ViewController.h"

#import <KnightWatson/KNWTheme.h>
#import "KNWThemeContext+Demo.h"

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
    [view       registerClass:UICollectionViewCell.class
   forCellWithReuseIdentifier:@"general"];
    
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
    self.navigationItem.titleView = segment;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSegmentValueChanged:(UISegmentedControl *)segment
{
    KNWThemeContext.defaultThemeContext.theme = _themes[segment.selectedSegmentIndex];
}

@end

@implementation ViewController (UICollectionView)

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell
    *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"general"
                                                      forIndexPath:indexPath];
    UIView
    *superview = cell.contentView;
    superview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel
    *label = [[UILabel alloc] initWithFrame:superview.bounds];
    [superview addSubview:label];
    label.text = @"Knight Watson";
    label.knw_themable.textColor = (id)
  @{KNWDTheme.daylight: UIColor.redColor,
    KNWDTheme.night: UIColor.blueColor,
    KNWDTheme.lawn: UIColor.greenColor,};
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 4;
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
