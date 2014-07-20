//
//  ContactsCell.h
//  QuickLink
//
//  Created by Leo on 14-7-20.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel * nameLabel;
@property (weak, nonatomic) IBOutlet UILabel * numberLabel;
@property (weak, nonatomic) IBOutlet UILabel * departmentLabel;
@end
