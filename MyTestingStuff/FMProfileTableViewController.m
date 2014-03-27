//
//  FMProfileTableViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/21/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMProfileTableViewController.h"
#import "FMLogOutViewController.h"
#import "FMPresentDetailTransition.h"
#import "FMDismissDetailTransition.h"

@interface FMProfileTableViewController () <UIAlertViewDelegate, UIViewControllerTransitioningDelegate>

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
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.user = [PFUser currentUser];
    [self setupView];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)logOutButtonPressed:(UIButton *)sender
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log out", nil];
//    [alertView show];
    
    FMLogOutViewController *logOutView = [[FMLogOutViewController alloc] init];
    logOutView.modalPresentationStyle = UIModalPresentationCustom;
    logOutView.transitioningDelegate = self;
    [self presentViewController:logOutView animated:YES completion:nil];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    else
    {
        return 1;
    }
}

#pragma mark - UIAlerView Delegate

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {
//        [PFUser logOut];
//        [self performSegueWithIdentifier:@"logoutSegue" sender:nil];
//    }
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UIViewControllerTransitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[FMPresentDetailTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[FMDismissDetailTransition alloc] init];
}


#pragma mark - Helper Methods

- (void)setupView
{
    if ([self.user[@"fullName"] isEqualToString:nil])
    {
        self.navBar.title = @"Profile";
    }
    else
    {
        self.navBar.title = self.user[@"fullName"];
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

- (void)logoutUser
{
    
}

@end
