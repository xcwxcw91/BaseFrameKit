//
//  BaseCollectionSectionModel.h
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/7.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseCollectionCellModel,BaseCollectionReusableViewHeader,BaseCollectionReusableViewFooter;

@interface BaseCollectionSectionModel : NSObject

@property (nonatomic, copy) NSString * headerTitle, * footerTitle;
@property (nonatomic, assign) NSInteger  selectedIndex;//default 0
@property (nonatomic, strong) BaseCollectionCellModel * selectedCellModel;

@property (nonatomic, weak) UICollectionView * collectionView;

@property (nonatomic, strong) BaseCollectionReusableViewHeader * headerView;
@property (nonatomic, strong) BaseCollectionReusableViewFooter * footerView;
// IF uses header/footer, then classes must be registered
@property (nonatomic, copy) NSString * headerViewClass;
@property (nonatomic, copy) NSString * footerViewClass;


@property (nonatomic, readonly) NSInteger cellModelCount;//该section下的cell/cellModel数量

//section 添加元素(加到最后面)
- (void)addCellModel:(__kindof BaseCollectionCellModel *)cellModel;

//从数组批量添加
- (void)addCellModelsFromArray:(NSArray <__kindof BaseCollectionCellModel *>*)arr;

//在指定index插入元素
- (void)insertCellModel:(__kindof BaseCollectionCellModel *)cellModel atIndex:(NSInteger)index;

//section 移除指定index的元素
- (void)removeCellModelAtIndex:(NSInteger)index;

//section 移除指定的元素
- (void)removeCellModel:(__kindof BaseCollectionCellModel*)cellModel;

//移除所有元素
- (void)removeAllCellModels;

//获取指定位置的元素
- (__kindof BaseCollectionCellModel *)cellModelAtIndex:(NSInteger)index;

//index
- (NSInteger)indexOfCellModel:(__kindof BaseCollectionCellModel *)cellModel;

//交换两个位置的元素
- (void)switchCellModelAtIndex:(NSInteger)index0 withCellModelAtIndex:(NSInteger)index1;

//获取所有的元素
- (NSArray <__kindof BaseCollectionCellModel *> *)getAllCellModels;

//获取元素总数
- (NSInteger)cellModelCount;

//遍历
- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(__kindof BaseCollectionCellModel * obj, NSUInteger idx, BOOL *stop))block;

//是否是最后一个项目
- (BOOL)isLastItem:(__kindof BaseCollectionCellModel *)cellModel;


//section级别 编辑模式
@property (nonatomic, assign, getter=isEdit) BOOL edit;//是否是编辑模式


@end
