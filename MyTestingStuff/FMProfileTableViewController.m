//
//  FMProfileTableViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMProfileTableViewController.h"

@interface FMProfileTableViewController ()

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;

@property (strong, nonatomic) PFUser *user;

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
    
    [self setupView];
    
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 0;
//}

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
    [formatter setDateFormat:@"MM-dd-yyyy"];
    self.birthDateLabel.text = [formatter stringFromDate:self.user[@"birthDate"]];
    
    self.cityLabel.text = self.user[@"city"];
    self.stateLabel.text = self.user[@"state"];
    self.genderLabel.text = self.user[@"gender"];
    
}


@end
