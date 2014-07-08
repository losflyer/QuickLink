//
//  YH_RootViewController.m
//  YH_InfoBoy
//
//  Created by Leo on 14-5-21.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "YH_RootViewController_iPhone.h"
#import "YH_HomeViewController.h"
#import "YH_NavigationViewController.h"

@interface YH_RootViewController_iPhone ()
@property (strong, nonatomic) YH_NavigationViewController * homePageNavi;
@end

@implementation YH_RootViewController_iPhone


+ (YH_RootViewController_iPhone *)sharedInstance
{
    static YH_RootViewController_iPhone *sharedRootViewInstance = nil;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedRootViewInstance = [[YH_RootViewController_iPhone alloc] initWithNibName:nil bundle:nil];
    });
    return sharedRootViewInstance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewManagerAdpter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Adpter
-(void)viewManagerAdpter
{
    [self jumpToHomeView];
    
}

- (void)jumpToHomeView
{
    [self addChildViewController:self.homePageNavi];
    [self.view addSubview:self.homePageNavi.view];
}



-(YH_NavigationViewController*)homePageNavi
{
    if (!_homePageNavi) {
        YH_HomeViewController *homeView = [[YH_HomeViewController alloc] init];
        
        _homePageNavi = [[YH_NavigationViewController alloc] initWithRootViewController:homeView];

        
    }
    return _homePageNavi;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
