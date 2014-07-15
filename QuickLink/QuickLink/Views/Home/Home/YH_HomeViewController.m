//
//  YH_HomeViewController.m
//  YH_InfoBoy
//
//  Created by Leo on 14-5-21.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "YH_HomeViewController.h"
#import "UIViewController+NJKFullScreenSupport.h"


@interface YH_HomeViewController () <UITableViewDataSource, UITableViewDelegate,  NJKScrollFullscreenDelegate>

@property (strong, nonatomic) NSArray* data;
@property (nonatomic) NJKScrollFullScreen *scrollProxy;
@end

@implementation YH_HomeViewController

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
    
    self.data = @[@"Awesome content", @"Great content", @"Amazing content", @"Ludicrous content", @"Awesome content", @"Great content", @"Amazing content", @"Ludicrous content", @"Awesome content", @"Great content", @"Amazing content", @"Ludicrous content", @"Awesome content", @"Great content", @"Amazing content", @"Ludicrous content"];
    [self.navigationController setTitle:@"root"];
 
	[self.callRecordTableView setDataSource:self];
    
    
    _scrollProxy = [[NJKScrollFullScreen alloc] initWithForwardTarget:self]; // UIScrollViewDelegate and UITableViewDelegate methods proxy to ViewController
    self.callRecordTableView.delegate = (id)_scrollProxy; // cast for surpress incompatible warnings
    _scrollProxy.delegate = self;
    
//      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetBars) name:UIApplicationWillEnterForegroundNotification object:nil]; // resume bars when back to forground from other apps
    
    if (!IS_RUNNING_IOS7) {
        // support full screen on iOS 6
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    }
        [self buttonsSetDefaulePosition];
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
//	[self showNavBarAnimated:NO];
 
}


- (void)dealloc
{
    self.callRecordTableView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
	}
	
	cell.textLabel.text = self.data[indexPath.row];
	
	return cell;
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
#pragma mark - Action



- (IBAction)leftButtonClick : (id)sender
{
    //    UIButton *btn = (UIButton *) sender;
    //    [self buttonJumpAnimation:btn];
}
- (IBAction)rightButtonClick : (id)sender
{
    //    UIButton *btn = (UIButton *) sender;
    //    [self buttonJumpAnimation:btn];
}

#pragma mark - Button Animation
- (void)buttonJumpAnimation{
    [self leftButtonJump];
    [self rightButtonJump];
}

-(void)leftButtonJump
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point =  self.leftButton.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y - 60)];
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    [self.leftButton pop_addAnimation:springAnimation forKey:@"changeposition"];

}

-(void)rightButtonJump
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point =  self.rightButton.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y - 60)];
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    [self.rightButton pop_addAnimation:springAnimation forKey:@"changeposition"];
}

- (void)buttonFallAnimation{
    [self leftButtonFall];
    [self rightButtonFall];
}


-(void)leftButtonFall
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point =  self.leftButton.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y + 60)];
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    [self.leftButton pop_addAnimation:springAnimation forKey:@"changeposition"];
    
}

-(void)rightButtonFall
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point =  self.rightButton.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y + 60)];
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    [self.rightButton pop_addAnimation:springAnimation forKey:@"changeposition"];
}



-(void)buttonsSetDefaulePosition
{
    self.leftButton.bottom = self.view.bottom - 20;
    self.rightButton.bottom = self.view.bottom - 20;
}


-(void)buttonsJump
{
    
//    [self buttonsSetDefaulePosition];
    [self buttonJumpAnimation];
}


-(void)buttonsFall
{
    
    [self buttonFallAnimation];
}


#pragma mark - ScrollNavigationDelegate

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollUp:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
    
}

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollDown:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollUp:(NJKScrollFullScreen *)proxy
{
    [self hideNavigationBar:YES];
    [self buttonsFall];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollDown:(NJKScrollFullScreen *)proxy
{
    [self showNavigationBar:YES];
    [self buttonsJump];
}
@end
