//
//  BaseSectionFooterView.h
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/4.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseSectionModel;
@interface BaseSectionFooterView : UITableViewHeaderFooterView//tableview 专用

//tag
@property (nonatomic, assign) NSInteger section;

- (void)setFooterData:(__weak BaseSectionModel *)sectionModel;


@end
