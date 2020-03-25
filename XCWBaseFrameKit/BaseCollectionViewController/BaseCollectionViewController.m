//
//  BaseCollectionViewController.m
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/7.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "XCWBaseKitHeader.h"
@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController
{
    BOOL _registered;
}
- (void)loadView{
    
    [super loadView];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page=1;
    self.pageSize=10;
    self.rows = 10;
}

# pragma mark - public

# pragma mark -  Refresh Load 方法
- (void)setCanRefresh:(BOOL)canRefresh{
    
    _canRefresh=canRefresh;
    if (canRefresh) {
        
        if (self.collectionView.mj_header==nil) {
            
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
            //设置header
            self.collectionView.mj_header = header;
        }
        else{
            self.collectionView.mj_header.hidden=NO;
        }
    }
    else{
        self.collectionView.mj_header.hidden=YES;
    }
}

- (void)refreshData{
    
    self.page =1;
    [self getData:NO];
}

- (void)setCanLoadMore:(BOOL)canLoadMore{
    
    _canLoadMore=canLoadMore;
    
    if (canLoadMore) {
        
        if (self.collectionView.mj_footer==nil) {
            
            MJRefreshFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            self.collectionView.mj_footer = footer;
        }
        else{
            [self.collectionView.mj_footer resetNoMoreData];
        }
    }
    else{
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)loadMoreData{
    
    [self getData:YES];
}

- (void)getData:(BOOL)isLoadMore{
    
}

- (void)stopRefresh{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView.mj_header endRefreshing];
        if (self.collectionView.mj_footer.state == MJRefreshStateNoMoreData) {
            [self.collectionView.mj_footer resetNoMoreData];
        }
    });
}

- (void)stopLoadMore{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.collectionView.mj_footer.state==MJRefreshStateNoMoreData) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        else if (self.collectionView.mj_footer.state==MJRefreshStateRefreshing){
            [self.collectionView.mj_footer endRefreshing];
        }
    });
}

- (void)endMJRefreshing{
    
    [self stopRefresh];
    [self stopLoadMore];
}

- (void)reloadData{
    
    [self registerClassesIfNecessary];
    
    if (self.collectionView.mj_header && self.collectionView.mj_header.state==MJRefreshStateRefreshing) {
        [self stopRefresh];
    }
    if (self.collectionView.mj_footer && (self.collectionView.mj_footer.state==MJRefreshStateRefreshing||self.collectionView.mj_footer.state==MJRefreshStateNoMoreData)){
        
        [self stopLoadMore];
    }
    [self.collectionView reloadData];
}

# pragma mark - to Be OVERRIDDEN
- (__kindof UICollectionViewLayout *)flowLayout{
    
    return [[UICollectionViewFlowLayout alloc] init];
}

- (void)registerClassesIfNecessary{
    
    if (_registered) return;
    _registered = true;
    
    for (BaseCollectionSectionModel * sectionModel in self.dataSource) {
        
        if (sectionModel.headerView) {
            
            [self.collectionView registerClass:NSClassFromString([sectionModel headerViewClass]) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[sectionModel headerViewClass]];
        }
        if (sectionModel.footerView) {
            
            [self.collectionView registerClass:NSClassFromString([sectionModel footerViewClass]) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[sectionModel footerViewClass]];
        }
        [sectionModel enumerateObjectsUsingBlock:^(BaseCollectionCellModel *cellModel, NSUInteger idx, BOOL *stop) {
            
            [self.collectionView registerClass:NSClassFromString([cellModel cellClassName]) forCellWithReuseIdentifier:[cellModel cellReuseIdentifer]];
        }];
    }
}

# pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    BaseCollectionSectionModel * sectionModel = [self.dataSource objectAtIndex:section];

    return [sectionModel cellModelCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseCollectionSectionModel * sectionModel = [self.dataSource objectAtIndex:indexPath.section];
    BaseCollectionCellModel * cellModel =  [sectionModel cellModelAtIndex:indexPath.item];
    
    return [cellModel itemSize];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseCollectionSectionModel * sectionModel = [self.dataSource objectAtIndex:indexPath.section];
    BaseCollectionCellModel * cellModel =  [sectionModel cellModelAtIndex:indexPath.item];
 
    BaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[cellModel cellReuseIdentifer] forIndexPath:indexPath];
    [cell setCellData:sectionModel cellModel:cellModel];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseCollectionSectionModel * sectionModel = [self.dataSource objectAtIndex:indexPath.section];
    BaseCollectionCellModel * cellModel =  [sectionModel cellModelAtIndex:indexPath.item];
    
    Class class = NSClassFromString(cellModel.cellJumpClassName);
    if (StringIsNull(cellModel.cellJumpClassName)) {
        return;
    }
    UIViewController * vc = (UIViewController *)[[class alloc] init];
    if (![self.navigationController.topViewController isKindOfClass:[vc class]]) {
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    BaseCollectionSectionModel * sectionModel = [self.dataSource objectAtIndex:indexPath.section];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && sectionModel.headerView) {
       
        BaseCollectionReusableViewHeader * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.headerViewClass forIndexPath:indexPath];
        
        [header setHeaderData:sectionModel];
        
        return header;
    }
    
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && sectionModel.footerView){
        
        BaseCollectionReusableViewFooter * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionModel.footerViewClass forIndexPath:indexPath];
        [footer setFooterData:sectionModel];
        
        return footer;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    BaseCollectionSectionModel * sectionModel = [self.dataSource objectAtIndex:section];
    
    if (sectionModel.cellModelCount ==0) {
        return CGSizeZero;
    }
    if (sectionModel.headerView) {
        return sectionModel.headerView.frame.size;
    }
    return CGSizeZero;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    BaseCollectionSectionModel * sectionModel = [self.dataSource objectAtIndex:section];
    
    if (sectionModel.cellModelCount ==0) {
        return CGSizeZero;
    }
    if (sectionModel.footerView) {
        return sectionModel.footerView.frame.size;
    }
    return CGSizeZero;
}


# pragma mark - getter
- (UICollectionView *)collectionView{
    
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self flowLayout]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (NSMutableArray<BaseCollectionSectionModel *> *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


@end
