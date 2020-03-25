//
//  XCWBaseKitHeader.h
//  XCWBaseKitDemo
//
//  Created by chunwei.xu on 2020/3/24.
//  Copyright © 2020 chunwei.xu. All rights reserved.
//

#ifndef XCWBaseKitHeader_h
#define XCWBaseKitHeader_h

#endif /* XCWBaseKitHeader_h */


#pragma mark - Headers
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


#import "BaseViewController.h"

#import "BaseTableViewController.h"
#import "BaseSectionModel.h"
#import "BaseTableViewCellModel.h"
#import "BaseSectionHeaderView.h"
#import "BaseSectionFooterView.h"
#import "BaseTableViewCell.h"
#import "BaseTableView.h"

#import "BaseCollectionViewController.h"
#import "BaseCollectionSectionModel.h"
#import "BaseCollectionCellModel.h"
#import "BaseCollectionReusableViewHeader.h"
#import "BaseCollectionReusableViewFooter.h"
#import "BaseCollectionViewCell.h"

#if __has_include (<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#if __has_include (<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif


#pragma mark - Defines
 
  

#pragma mark - Methods
NS_INLINE BOOL StringIsNull(NSString * string){
    
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (!string || [string isKindOfClass:[NSNull class]] || string.length == 0 || [string isEqualToString:@""] || [string isEqualToString:@"<null>"]) {
        return YES;
    }else{
        return NO;
    }
}


NS_INLINE NSString * NonNullString(NSString * string){
    
    return StringIsNull(string)?@"":string;
}

NS_INLINE UIViewController * CurrentViewController(){
    
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
