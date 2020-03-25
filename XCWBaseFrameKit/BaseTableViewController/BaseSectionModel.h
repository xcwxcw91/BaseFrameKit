//
//  BaseSectionModel.h
//  PresentPushTest
//
//  Created by Allen_Xu on 2017/12/2.
//  Copyright © 2017年 SDUSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BaseSectionHeaderView,BaseSectionFooterView,BaseTableViewCellModel,BaseTableViewController;

@interface BaseSectionModel : NSObject


@property (nonatomic, assign) NSInteger selectedIndex;//temporary store

//weak references
@property (nonatomic, weak, nullable) __kindof BaseTableViewController * hostVC;

@property (nonatomic, weak, nullable) UITableView * tableView;

@property (nonatomic, weak) id unspecifiedHost;//关联的控制器或者view，用于弱引用其方法

@property (nonatomic, copy) NSString * unspecifiedArg;//定义的一个模糊的传值属性 在使用的地方注释其意义


//简单业务情况下可以使用与sectionModel绑定的header/footer
@property (nonatomic, strong) BaseSectionHeaderView * headerView;
@property (nonatomic, strong) BaseSectionFooterView * footerView;

@property (nonatomic, readonly) NSInteger cellModelCount;//该section下的cell/cellModel数量 不可用于kvc/kvo

//section 添加元素(加到最后面) 单个添加
- (void)addCellModel:(BaseTableViewCellModel *)cellModel;

- (void)addCellModelsFromArray:(NSArray <BaseTableViewCellModel *>*)arr;

//在指定index插入元素
- (void)insertCellModel:(BaseTableViewCellModel *)cellModel atIndex:(NSInteger)index;

//section 移除指定index的元素
- (void)removeCellModelAtIndex:(NSInteger)index;

//section 移除指定的model
- (void)removeCellModel:(BaseTableViewCellModel *)cellModel;

//移除所有元素
- (void)removeAllCellModels;

//获取指定位置的元素
- (__kindof BaseTableViewCellModel *)cellModelAtIndex:(NSInteger)index;

//获取cellmodel所在的index
- (NSInteger)indexOfCellModel:(BaseTableViewCellModel *)cellModel;

//交换两个位置的元素
- (void)switchCellModelAtIndex:(NSInteger)index0 withCellModelAtIndex:(NSInteger)index1;

//获取所有的元素
- (NSArray <BaseTableViewCellModel *> *)getAllCellModels;

//获取元素总数
- (NSInteger)cellModelCount;

//遍历
- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(BaseTableViewCellModel * obj, NSUInteger idx, BOOL *stop))block;

//CUSTOM
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign) BOOL canRefresh;
@property(nonatomic,assign) BOOL canLoadMore;


@end
