//
//  ViewController.m
//  KNWThemeDemo
//
//  Created by William on 3/5/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@interface ViewController (UICollectionView) <
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@end

@implementation ViewController

- (void)loadView
{
    self.view = [[UICollectionView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UICollectionView
    *view = (UICollectionView *)self.view;
    UICollectionViewFlowLayout
    *layout = [[UICollectionViewFlowLayout alloc] init];
    
    view.collectionViewLayout = layout;
    view.delegate = self;
    view.dataSource = self;
    
    [view       registerClass:UICollectionViewCell.class
   forCellWithReuseIdentifier:@"general"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UILabel
    *label = [[UILabel alloc] initWithFrame:superview.bounds];
    [superview addSubview:label];
    label.text = @"Knight Watson;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

@end