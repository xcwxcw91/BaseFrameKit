//
//  BaseTableViewCell.m
//  PresentPushTest
//
//  Created by Allen_Xu on 2017/12/2.
//  Copyright © 2017年 SDUSZ. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
 
    }
    return self;
}

- (void)setCellData:(BaseSectionModel *)sectionModel cellModel:(BaseTableViewCellModel *)cellModel{
    
}


@end
