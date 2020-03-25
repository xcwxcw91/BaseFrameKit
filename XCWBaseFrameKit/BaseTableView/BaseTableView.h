//
//  BaseTableView.h
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/10.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseSectionModel,BaseTableViewCellModel;

@interface BaseTableView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)BOOL canRefresh;
@property(nonatomic,assign)BOOL canLoadMore;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)int rows;

@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray <BaseSectionModel *>* dataSource;
@property (nonatomic, copy) void (^ didSelectRowAtIndexPathBlock)(NSIndexPath * indexPath, BaseTableViewCellModel * cellModel);

@property (nonatomic, copy) void (^ didSelectRowInSectionAtIndexPathBlock)(NSIndexPath * indexPath, BaseTableViewCellModel * cellModel, BaseSectionModel * sectionModel);


- (void)refreshData;

- (void)loadMoreData;

- (void)getData:(BOOL)isLoadMore;

- (void)config;

- (void)reloadData;

- (void)endMJRefreshing;
@end


@interface BaseTableView (SectionReload)

- (void)reloadSection:(__kindof BaseSectionModel *)sectionModel;

- (void)reloadRow:(__kindof BaseTableViewCellModel *)cellModel inSection:(__kindof BaseSectionModel *)sectionModel;

@end
