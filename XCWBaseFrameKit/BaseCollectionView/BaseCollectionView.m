//
//  BaseCollectionView.m
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/17.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import "BaseCollectionView.h"
#import "XCWBaseKitHeader.h"
 

@interface BaseCollectionView ()
{
    UICollectionViewFlowLayout * _flowLayout;
    BOOL _registered;
}
@end
@implementation BaseCollectionView
 

- (instancetype)init{
    
    if (self = [super init]) {
        
        _flowLayout = [self flowLayout];
        [self config];
    }
    return self;
}

- (instancetype)initWithLayout:(UICollectionViewFlowLayout * _Nullable)layout{
    
    if (self = [super init]) {
        _flowLayout = layout?:[self flowLayout];
        [self config];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout * _Nullable)layout{
    
    if (self = [super initWithFrame:frame]) {
        _flowLayout = layout?:[self flowLayout];
        [self config];
    }
    return self;
}

- (void)config{
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

# pragma mark - public
- (void)reload{
    
    [self registerClassesIfNecessary];
    [self.collectionView reloadData];
}

# pragma mark -
- (UICollectionViewFlowLayout *)flowLayout{
    
    return [[UICollectionViewFlowLayout alloc] init];
}

- (void)registerClassesIfNecessary{
    
    if (_registered)  return;
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
    
    if (self.didSelectItemAtIndexPathBlock) {
        self.didSelectItemAtIndexPathBlock(indexPath, cellModel);
    }
    
    Class class = NSClassFromString(cellModel.cellJumpClassName);
    if (StringIsNull(cellModel.cellJumpClassName)) {
        return;
    }
    UIViewController * vc = (UIViewController *)[[class alloc] init];
    
    UIViewController * topVc = CurrentViewController();
    
    if (![topVc.navigationController.topViewController isKindOfClass:[vc class]]) {
        
        [topVc.navigationController pushViewController:vc animated:YES];
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
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
