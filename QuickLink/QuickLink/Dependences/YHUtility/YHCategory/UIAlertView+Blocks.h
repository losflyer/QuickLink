//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

/*
 One.
 RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"No" action:^{
 // this is the code that will be executed when the user taps "No"
 // this is optional... if you leave the action as nil, it won't do anything
 // but here, I'm showing a block just to show that you can use one if you want to.
 }];
 
 RIButtonItem *deleteItem = [RIButtonItem itemWithLabel:@"Yes" action:^{
 // this is the code that will be executed when the user taps "Yes"
 // delete the object in question...
 [context deleteObject:theObject];
 }];

 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete This Item?"
 message:@"Are you sure you want to delete this really important thing?"
 cancelButtonItem:cancelItem
 otherButtonItems:deleteItem, nil];
 [alertView show];

 Tow.
 [[[UIAlertView alloc] initWithTitle:@"Delete This Item?"
 message:@"Are you sure you want to delete this really important thing?"
 cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
 // Handle "Cancel"
 }]
 otherButtonItems:[RIButtonItem itemWithLabel:@"Delete" action:^{
 // Handle "Delete"
 }], nil] show];
*/


@interface UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(RIButtonItem *)item;

@end
