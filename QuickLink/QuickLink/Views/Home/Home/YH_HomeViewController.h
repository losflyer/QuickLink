//
//  YH_HomeViewController.h
//  YH_InfoBoy
//
//  Created by Leo on 14-5-21.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKScrollFullScreen.h"
@interface YH_HomeViewController : UIViewController
@property (weak, nonatomic)  IBOutlet UIButton * leftButton;
@property (weak, nonatomic)  IBOutlet UIButton * rightButton;
@property (weak, nonatomic)  IBOutlet UITableView * callRecordTableView;
- (IBAction)leftButtonClick : (id)sender;
- (IBAction)rightButtonClick : (id)sender;
@end
