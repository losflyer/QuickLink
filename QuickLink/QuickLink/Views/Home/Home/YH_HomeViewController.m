//
//  YH_HomeViewController.m
//  YH_InfoBoy
//
//  Created by Leo on 14-5-21.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "YH_HomeViewController.h"
#import "UIViewController+NJKFullScreenSupport.h"
#import "ASOTwoStateButton.h"
#import "ASOBounceButtonViewDelegate.h"
#import "BounceButtonView.h"

@interface YH_HomeViewController () <UITableViewDataSource, UITableViewDelegate,  NJKScrollFullscreenDelegate, ASOBounceButtonViewDelegate>
{
    BOOL isTop;
}
@property (strong, nonatomic) NSArray* data;
@property (nonatomic) NJKScrollFullScreen *scrollProxy;

@property (strong, nonatomic) IBOutlet ASOTwoStateButton *menuButton;
@property (strong, nonatomic) BounceButtonView *menuItemView;
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
    
    isTop = YES;
    
    {//jumpMenu
        // Set the 'menu button'
        [self.menuButton initAnimationWithFadeEffectEnabled:YES]; // Set to 'NO' to disable Fade effect between its two-state transition
        
        // Get the 'menu item view' from storyboard
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"QuickLinkMain" bundle:nil];
        UIViewController *menuItemsVC = (UIViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ExpandMenu"];
        self.menuItemView = (BounceButtonView *)menuItemsVC.view;
        
        NSArray *arrMenuItemButtons = [[NSArray alloc] initWithObjects:self.menuItemView.menuItem1,
                                       self.menuItemView.menuItem2,
                                       self.menuItemView.menuItem3,
                                       self.menuItemView.menuItem4,
                                       nil]; // Add all of the defined 'menu item button' to 'menu item view'
        [self.menuItemView addBounceButtons:arrMenuItemButtons];
        
        // Set the bouncing distance, speed and fade-out effect duration here. Refer to the ASOBounceButtonView public properties
        [self.menuItemView setBouncingDistance:[NSNumber numberWithFloat:0.7f]];
        
        // Set as delegate of 'menu item view'
        [self.menuItemView setDelegate:self];
    }

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

- (void)viewDidAppear:(BOOL)animated
{
    // Tell 'menu button' position to 'menu item view'
    [self.menuItemView setAnimationStartFromHere:self.menuButton.frame];
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


- (IBAction)menuButtonAction:(id)sender
{
    if ([sender isOn]) {
        // Show 'menu item view' and expand its 'menu item button'
        [self.menuButton addCustomView:self.menuItemView];
        [self.menuItemView expandWithAnimationStyle:ASOAnimationStyleExpand];
    }
    else {
        // Collapse all 'menu item button' and remove 'menu item view'
        [self.menuItemView collapseWithAnimationStyle:ASOAnimationStyleExpand];
        [self.menuButton removeCustomView:self.menuItemView interval:[self.menuItemView.collapsedViewDuration doubleValue]];
    }
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
    if (!isTop)
    [self buttonJumpAnimation];
    isTop = YES;
}


-(void)buttonsFall
{
    if (isTop)
    [self buttonFallAnimation];
    isTop = NO;
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

#pragma mark - Menu item view delegate method

- (void)didSelectBounceButtonAtIndex:(NSUInteger)index
{
    // Collapse all 'menu item button' and remove 'menu item view' once a menu item is selected
    [self.menuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // Set your custom action for each selected 'menu item button' here
    NSString *alertViewTitle = [NSString stringWithFormat:@"Menu Item %x is selected", (short)index];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
@end
