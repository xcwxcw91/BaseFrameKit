//
//  BaseTableViewController.h
//  PresentPushTest
//
//  Created by Allen_Xu on 2017/12/2.
//  Copyright © 2017年 SDUSZ. All rights reserved.
//

#import "XCWBaseKitHeader.h"
#import "BaseViewController.h"

@class BaseSectionModel,BaseTableViewCellModel;

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) BOOL canRefresh;
@property(nonatomic,assign) BOOL canLoadMore;
@property(nonatomic,assign) int page;
@property(nonatomic,assign) int pageSize;
@property(nonatomic,assign) int rows;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray <BaseSectionModel *>* dataSource;

- (void)getData:(BOOL)isLoadMore;

- (void)refreshData;

- (void)reloadData;

- (void)endMJRefreshing;

- (UITableViewStyle)tableViewStyle;

//TO BE OVERRIDDEN
- (BOOL)showSectionHeaderWhileNoCellData:(BaseSectionModel *)sectionModel;

- (BOOL)showSectionFooterWhileNoCellData:(BaseSectionModel *)sectionModel;

@end


@interface BaseTableViewController (SectionReload)

- (void)reloadSection:(__kindof BaseSectionModel *)sectionModel;

- (void)reloadRow:(__kindof BaseTableViewCellModel *)cellModel inSection:(__kindof BaseSectionModel *)sectionModel;

@end
