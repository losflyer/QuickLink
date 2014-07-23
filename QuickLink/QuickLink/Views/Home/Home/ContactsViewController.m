//
//  ContactsViewController.m
//  QuickLink
//
//  Created by Leo on 14-7-17.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactsEntities.h"
#import "ContactsCell.h"

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSString *cellIdentifier;
}
@property (strong, nonatomic) NSArray *contactsArray;
@property (weak,   nonatomic) IBOutlet UITableView *contactsTableView;
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
    cellIdentifier = NSStringFromClass([ContactsCell class]);
    [self.contactsTableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
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
                                   entityForName:@"ContactsEntities" inManagedObjectContext:[[Global sharedInstance] getCurrentManagedObjectContext]];
    
    
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:sort];
    NSError *error;
    NSArray * fetchedObjects = [[[Global sharedInstance] getCurrentManagedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    self.contactsArray = [NSArray arrayWithArray:fetchedObjects];

}
#pragma mark - Table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.contactsArray count] );
     return [self.contactsArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ContactsEntities *info  = [self.contactsArray objectAtIndex:indexPath.row];

    cell.nameLabel.text = info.name;
    cell.numberLabel.text = info.number;
    cell.departmentLabel.text = info.department;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ContactsEntities *info  = [self.contactsArray objectAtIndex:indexPath.row];
    [YH_Utils callByPhoneNumer:info.number];
    
}
@end
