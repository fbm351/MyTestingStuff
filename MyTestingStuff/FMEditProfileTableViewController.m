//
//  FMEditProfileTableViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/21/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMEditProfileTableViewController.h"
#define kDatePickerIndex 4
#define kStatePickerIndex 7
#define kGenderPickerIndex 9
#define kDatePickerCellHeight 165
#define kGenderPickerCellHeight 165


@interface FMEditProfileTableViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *birthDateDatePicker;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *statePicker;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSArray *genders;
@property (strong, nonatomic) NSArray *states;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *gender;



@end

@implementation FMEditProfileTableViewController

- (PFUser *)user
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
    
    
    self.genders = @[@"male", @"female"];
    self.states = @[@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana",@"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin",@"Wyoming"];
    
    self.genderPicker.delegate = self;
    self.genderPicker.dataSource = self;
    
    self.statePicker.delegate = self;
    self.statePicker.dataSource = self;
    
    self.user = [PFUser currentUser];
    self.birthDateDatePicker.hidden = YES;
    self.statePicker.hidden = YES;
    self.genderPicker.hidden = YES;

    [self setUpView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender
{
    [self saveUserToParse];
}

- (IBAction)birthDateChanged:(UIDatePicker *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.birthDateLabel.text = [formatter stringFromDate:sender.date];
    self.birthDate = sender.date;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = self.tableView.rowHeight;
    
    //NSLog(@"Row in Height for Row %i", indexPath.row);
    
    if (indexPath.row  == kDatePickerIndex)
    {
        if (self.birthDateDatePicker.hidden == YES) {
            height = 0.0f;
        }
        else
        {
            height = kDatePickerCellHeight;
        }
        NSLog(@"height = %f", height);
    }
    else if (indexPath.row == kStatePickerIndex)
    {
        if (self.statePicker.hidden == YES)
        {
            height = 0.0f;
        }
        else
        {
            height = kDatePickerCellHeight;
        }
    }
    else if (indexPath.row == kGenderPickerIndex)
    {
        if (self.genderPicker.hidden == YES) {
            height = 0.0f;
        }
        else
        {
            height = kGenderPickerCellHeight;
        }
    }
    return height;
}

#pragma mark - Table View Delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row in didSelect Row %i", indexPath.row);
    if (indexPath.row == kDatePickerIndex - 1)
    {
        if (self.birthDateDatePicker.hidden == NO)
        {
            [self hideCellAtIndexPath:indexPath];
        }
        else
        {
            [self showCellAtIndexPath:indexPath];
        }
    }
    else if (indexPath.row == kStatePickerIndex - 1)
    {
        if (self.statePicker.hidden == NO)
        {
            [self hideCellAtIndexPath:indexPath];
        }
        else
        {
            [self showCellAtIndexPath:indexPath];
        }
    }
    else if (indexPath.row == kGenderPickerIndex - 1)
    {
        if (self.genderPicker.hidden == NO)
        {
            [self hideCellAtIndexPath:indexPath];
        }
        else
        {
            [self showCellAtIndexPath:indexPath];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIPickerView Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.statePicker)
    {
        NSString *state = self.states[row];
        self.state = state;
        self.stateLabel.text = self.state;
    }
    else
    {
        NSString *gender = self.genders[row];
        self.gender = gender;
        self.genderLabel.text = self.gender;
    }
}

#pragma mark - UIPickerView Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.statePicker)
    {
        return [self.states count];
    }
    else
    {
        return [self.genders count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.statePicker)
    {
        NSString *state = self.states[row];
        return state;
    }
    else
    {
        NSString *gender = self.genders[row];
        return gender;
    }
}

#pragma mark - Helper Methods

- (void)setBirthdayLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSDate *defaultDate = [NSDate date];
    
    if (self.user[@"birthDate"] == nil) {
        self.birthDateLabel.text = [formatter stringFromDate:defaultDate];
        self.birthDate = defaultDate;
    }
    else
    {
        self.birthDateLabel.text = [formatter stringFromDate:self.user[@"birthDate"]];
        self.birthDate = self.user[@"birthDate"];
        self.birthDateDatePicker.date = self.birthDate;
    }
    
}

- (void)showCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    NSLog(@"Row in hide cell %i", indexPath.row);
    
    if (indexPath.row == kDatePickerIndex - 1) {
        self.birthDateDatePicker.hidden = NO;
        self.birthDateDatePicker.alpha = 0.0f;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.birthDateDatePicker.alpha = 1.0f;
        }];
    }
    else if (indexPath.row == kStatePickerIndex - 1)
    {
        self.statePicker.hidden = NO;
        self.statePicker.alpha = 0.0f;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.statePicker.alpha = 1.0f;
        }];
    }
    else if (indexPath.row == kGenderPickerIndex - 1)
    {
        self.genderPicker.hidden = NO;
        self.genderPicker.alpha = 0.0f;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.genderPicker.alpha = 1.0f;
        }];
    }
    [self.tableView reloadData];
}

- (void)hideCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row in Show Cell %i", indexPath.row);
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    if (indexPath.row == kDatePickerIndex - 1)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.birthDateDatePicker.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.birthDateDatePicker.hidden = YES;
            [self.tableView reloadData];
        }];
    }
    else if (indexPath.row == kStatePickerIndex - 1)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.statePicker.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.statePicker.hidden = YES;
            [self.tableView reloadData];
        }];
    }
    else if (indexPath.row == kGenderPickerIndex - 1)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.genderPicker.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.genderPicker.hidden = YES;
            [self.tableView reloadData];
        }];
    }
    
}

- (void)setUpView
{
    self.emailLabel.text = self.user.email;
    self.firstNameTextField.text = self.user[@"firstName"];
    self.lastNameTextField.text = self.user[@"lastName"];
    [self setBirthdayLabel];
    self.cityTextField.text = self.user[@"city"];
    
    if (self.user[@"state"] == nil)
    {
        self.stateLabel.text = @"Select State";
    }
    else
    {
        self.stateLabel.text = self.user[@"state"];
    }
    
    if (self.user[@"gender"] == nil)
    {
        self.genderLabel.text = @"Select Gender";
    }
    else
    {
        self.genderLabel.text = self.user[@"gender"];
    }
}

- (void)saveUserToParse
{
    self.user[@"firstName"] = self.firstNameTextField.text;
    self.user[@"lastName"] = self.lastNameTextField.text;
    self.user[@"birthDate"] = self.birthDate;
    self.user[@"city"] = self.cityTextField.text;
    self.user[@"state"] = self.state;
    self.user[@"gender"] = self.gender;
    //self.user[@"fullName"] = [NSString stringWithFormat:@"%@ %@", self.firstNameTextField.text, self.lastNameTextField.text];
    
    NSLog(@"%@", self.user);
    
//    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error)
//        {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            NSString *errorString = [error userInfo][@"error"];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save Error!" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
//        }
//    }];
}



@end
