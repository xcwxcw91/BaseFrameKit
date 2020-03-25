//
//  BaseCollectionViewController.h
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/7.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import "BaseViewController.h"

@class BaseCollectionSectionModel;

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
 
@property (strong, nonatomic) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray <BaseCollectionSectionModel *>* dataSource;

@property(nonatomic,assign)BOOL canRefresh;
@property(nonatomic,assign)BOOL canLoadMore;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)int rows;

- (void)getData:(BOOL)isLoadMore;

- (void)reloadData;

- (void)endMJRefreshing;

@end
