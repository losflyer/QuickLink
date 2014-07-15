//
//  YH_HomeViewController.m
//  YH_InfoBoy
//
//  Created by Leo on 14-5-21.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "YH_HomeViewController.h"
#import "UIViewController+ScrollingNavbar.h"
@interface YH_HomeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) NSArray* data;
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
    // Do any additional setup after loading the view.
    [self.callRecordTableView setDelegate:self];
	[self.callRecordTableView setDataSource:self];
    [self followScrollView:self.callRecordTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self showNavBarAnimated:NO];
}

#pragma mark - nav + scroll
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	// This enables the user to scroll down the navbar by tapping the status bar.
	[self performSelector:@selector(showNavbar) withObject:nil afterDelay:0.1];
	
	return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

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

- (void)buttonJumpAnimation:(UIView*) jumpView{
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point = jumpView.center;
    
    if (point.y==240) {
        springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, -230)];
    }
    else{
        springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, 240)];
    }
    
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    
    [jumpView pop_addAnimation:springAnimation forKey:@"changeposition"];
    
}


- (IBAction)leftButtonClick : (id)sender
{
    UIButton *btn = (UIButton *) sender;
    [self buttonJumpAnimation:btn];
}
- (IBAction)rightButtonClick : (id)sender
{
    UIButton *btn = (UIButton *) sender;
    [self buttonJumpAnimation:btn];
}

@end
