//
//  FMProfileTableViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/21/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMProfileTableViewController.h"

@interface FMProfileTableViewController ()

@property (strong, nonatomic) PFUser *user;

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;


@end

@implementation FMProfileTableViewController

-(PFUser *)user
{
    if (!_user) {
        _user = [[PFUser alloc] init];
    }
    return _user;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.user = [PFUser currentUser];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - Helper Methods

- (void)setupView
{
    if ([self.user[@"firstName"] isEqualToString:nil])
    {
        self.navBar.title = @"Profile";
    }
    else
    {
        self.navBar.title = self.user[@"firstName"];
    }
    
    self.emailLabel.text = self.user.username;
    self.firstNameLabel.text = self.user[@"firstName"];
    self.lastNameLabel.text = self.user[@"lastName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    self.birthDateLabel.text = [formatter stringFromDate:self.user[@"birthDate"]];
    
    self.cityLabel.text = self.user[@"city"];
    self.stateLabel.text = self.user[@"state"];
    self.genderLabel.text = self.user[@"gender"];    
}

@end
