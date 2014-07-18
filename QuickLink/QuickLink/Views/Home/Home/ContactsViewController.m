//
//  ContactsViewController.m
//  QuickLink
//
//  Created by Leo on 14-7-17.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@end

@implementation ContactsViewController

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
    [self initContactsDataBase];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)initContactsDataBase
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ContactsEntities" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
//    self.failedBankInfos = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
}


@end
