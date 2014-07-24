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

#import "ContactsViewController.h"
#import "CallRecordViewController.h"
#import "SettingViewController.h"
#define kButtonJumpDistance 70
@interface YH_HomeViewController () < ASOBounceButtonViewDelegate, NJKScrollFullscreenDelegate>
{
    BOOL isTop;
    MenuButtonStatus buttonStatus;
}


@property (strong, nonatomic) IBOutlet ASOTwoStateButton *menuButton;
@property (weak, nonatomic) UIView *currentView;
@property (strong, nonatomic) BounceButtonView *menuItemView;


@property (strong, nonatomic) ContactsViewController* contactVC;
@property (strong, nonatomic) CallRecordViewController* callRecordVC;
@property (strong, nonatomic) SettingViewController* setttingVC;


@property (strong, nonatomic) NJKScrollFullScreen  * scrollProxy;
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
    [self.navigationController setTitle:@"root"];
    [self addNewViewToRoot:CALLRECODR_STATUS];

    
    if (!IS_RUNNING_IOS7) {
        // support full screen on iOS 6
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    }
    [self buttonsSetDefaulePosition];
    
    isTop = YES;
    
    _scrollProxy = [[NJKScrollFullScreen alloc] initWithForwardTarget:self]; // UIScrollViewDelegate and UITableViewDelegate methods proxy to ViewController
    self.callRecordVC.callrecordTable.delegate = (id)_scrollProxy;
    _scrollProxy.delegate = self;
    
    {//jumpMenu
        // Set the 'menu button'
        [self.menuButton initAnimationWithFadeEffectEnabled:YES]; // Set to 'NO' to disable Fade effect between its two-state transition
        
        // Get the 'menu item view' from storyboard
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"QuickLinkMain" bundle:nil];
        UIViewController *menuItemsVC = (UIViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ExpandMenu"];
        self.menuItemView = (BounceButtonView *)menuItemsVC.view;
        
        NSArray *arrMenuItemButtons = [[NSArray alloc] initWithObjects:
                                       self.menuItemView.menuItem1,
                                       self.menuItemView.menuItem2,
                                       self.menuItemView.menuItem3,
                                       nil]; // Add all of the defined 'menu item button' to 'menu item view'
        [self.menuItemView addBounceButtons:arrMenuItemButtons];
        
        // Set the bouncing distance, speed and fade-out effect duration here. Refer to the ASOBounceButtonView public properties
        [self.menuItemView setBouncingDistance:[NSNumber numberWithFloat:0.8f]];
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
//    self.callRecordTableView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (IBAction)menuButtonAction:(id)sender
{
    if (!isTop) {
        return;
    }
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
    [self menuButtonJump];
}

-(void)menuButtonJump
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point =  self.menuButton.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y - kButtonJumpDistance)];
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    [self.menuButton pop_addAnimation:springAnimation forKey:@"changeposition"];

}

- (void)buttonFallAnimation{
    [self menuButtonFall];
}


-(void)menuButtonFall
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point =  self.menuButton.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y + kButtonJumpDistance)];
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    [self.menuButton pop_addAnimation:springAnimation forKey:@"changeposition"];
    
}


-(void)buttonsSetDefaulePosition
{
    self.menuButton.bottom = self.view.bottom - 20;
}


-(void)buttonsJump
{
    
    if (!isTop)
    {
        [self buttonJumpAnimation];
        isTop = YES;
    }
}


-(void)buttonsFall
{
    if (isTop)
    {
        [self buttonFallAnimation];
        isTop = NO;
    }
}




#pragma mark - Menu item view delegate method

- (void)didSelectBounceButtonAtIndex:(NSUInteger)index
{
    // Collapse all 'menu item button' and remove 'menu item view' once a menu item is selected
    [self.menuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    
    if (index != buttonStatus) {
        [self addNewViewToRoot:index];
        [self fourth_animations];
    }
}


-(void)addNewViewToRoot:(MenuButtonStatus)btnStatus
{

    switch (btnStatus) {
        case CALLRECODR_STATUS:
        {
            [self changeCurrentView:self.callRecordVC];
        }
            break;
        case CONTACTS_STATUS:
        {
            [self changeCurrentView:self.contactVC];
        }
            break;
        case SETTING_STATUS:
        {
            [self changeCurrentView:self.setttingVC];
        }
            break;
        default:
        {
            
        }
            break;
    }
    buttonStatus = btnStatus;
}
-(void)changeCurrentView:(UIViewController*)inVC
{
    [self.view insertSubview:inVC.view belowSubview:_menuButton];
    [_currentView removeFromSuperview];
    _currentView = inVC.view;
    
}

- (void) fourth_animations
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.6f;      
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"rippleEffect";  //@"cube" @"moveIn" @"reveal" @"fade"(default) @"pageCurl" @"pageUnCurl" @"suckEffect" @"rippleEffect" @"oglFlip"
    transition.subtype = kCATransitionFromRight;
    transition.removedOnCompletion = YES;
    transition.fillMode = kCAFillModeBackwards;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
}


- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollUp:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
    [self buttonsFall];
}

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollDown:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
     [self buttonsJump];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollUp:(NJKScrollFullScreen *)proxy
{
    [self hideNavigationBar:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollDown:(NJKScrollFullScreen *)proxy
{
    [self showNavigationBar:YES];
}

#pragma mark - Get

-(ContactsViewController*)contactVC
{
    if (!_contactVC) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"QuickLinkMain" bundle:nil];
        
        _contactVC = (ContactsViewController*)[board instantiateViewControllerWithIdentifier:@"ContactViewControllerSI"];
    }
    return _contactVC;
}

-(CallRecordViewController*)callRecordVC
{
    if (!_callRecordVC) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"QuickLinkMain" bundle:nil];
        
        _callRecordVC = (CallRecordViewController*)[board instantiateViewControllerWithIdentifier:@"CallRecordViewControllerSI"];
       
    }
    return _callRecordVC;
}

-(SettingViewController*)setttingVC
{
    if (!_setttingVC) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"QuickLinkMain" bundle:nil];
        
        _setttingVC = (SettingViewController*)[board instantiateViewControllerWithIdentifier:@"SettingViewControllerSI"];
    }
    return _setttingVC;
}
@end
