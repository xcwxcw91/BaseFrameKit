//
//  BaseViewController.m
//  PresentPushTest
//
//  Created by Allen_Xu on 2017/12/4.
//  Copyright © 2017年 SDUSZ. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
    
}

- (void)viewWillAppear:(BOOL)animated{
    

    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
 
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
#if DEBUG
//    YYFPSLabel * fps = [[YYFPSLabel alloc] initWithFrame:CGRectMake(kScreenWidth-50, 64, 50, 25)];
//    [self.view addSubview:fps];
#endif
  
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

- (void)loadView{
    
    [super loadView];
  
 }

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout= UIRectEdgeNone;

//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//    backItem.title = @"";
//
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"backArrow_white"];
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"backArrow_white"];
//    self.navigationItem.backBarButtonItem = backItem;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11) {
        
    }
    else{
        
        do {
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
        self.automaticallyAdjustsScrollViewInsets = NO;
        _Pragma("clang diagnostic pop")
        } while (0);
       
    }
}

 
 



@end
