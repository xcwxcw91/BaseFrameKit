//
//  BaseCollectionView.h
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/17.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseCollectionSectionModel;
@class BaseCollectionCellModel;

@interface BaseCollectionView : UIView<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray <BaseCollectionSectionModel *>* dataSource;

@property (nonatomic, copy) void (^ didSelectItemAtIndexPathBlock)(NSIndexPath * indexPath, BaseCollectionCellModel * cellModel);

- (instancetype)initWithLayout:( UICollectionViewFlowLayout * _Nullable )layout;

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout * _Nullable)layout;

- (void)reload;
@end
