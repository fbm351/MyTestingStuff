//
//  FMFriendsViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/18/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMFriendsViewController.h"

@interface FMFriendsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *friends;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMFriendsViewController

- (NSMutableArray *)friends
{
    if (!_friends) {
        _friends = [[NSMutableArray alloc] init];
    }
    return _friends;
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
    [self queryForFriends];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = self.friends[indexPath.row];
    
    if (user[@"firstName"] == nil) {
        cell.textLabel.text = user.username;
    }
    else
    {
        cell.textLabel.text = user[@"fullName"];
    }
    
    
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

#pragma mark - Helper Methods

- (void)queryForFriends
{
    PFQuery *userQuery = [PFUser query];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.friends = [objects mutableCopy];
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"%@", error);
        }
    }];
}

@end
