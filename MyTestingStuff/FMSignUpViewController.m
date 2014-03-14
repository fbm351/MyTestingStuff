//
//  FMSignUpViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/8/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMSignUpViewController.h"

@interface FMSignUpViewController () <UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (assign, nonatomic) id currentResponder;
@property (strong, nonatomic) IBOutlet UILabel *emailTakenLabel;

@end

@implementation FMSignUpViewController


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
    
    //Create a tap recognizer and set it to 1 tap and add to the view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
    //Setup the delegates
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    
    self.emailTakenLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)signUpButtonPressed:(UIButton *)sender
{
    [self checkUserForSignUp];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField Delegates


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 3 && (self.emailTextField.text.length == 0 || self.passwordTextField.text.length == 0 || self.confirmPasswordTextField.text.length == 0 ))
    {
        [self.emailTextField becomeFirstResponder];
    }
    else
    {
        [[self.view viewWithTag:textField.tag + 1] becomeFirstResponder];
    }
    [[self.view viewWithTag:textField.tag + 1] becomeFirstResponder];
    return YES;
}


//When text field is starts editing set that text field to current responder.
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1)
    {
        [self emailValidationChecksForTextField:textField];
    }
    self.currentResponder = nil;
}

#pragma mark - Helper Methods

//Closes keyboard when user taps on other parts of screen
- (void)resignOnTap:(id)sender
{
    [self.currentResponder resignFirstResponder];
}


//Checks to make sure that all the valid fields are filled and that the format of the email address is valid and that the password is at least 6 characters long and that the passwords match.  If they do calls the saveToParse method.
- (void)checkUserForSignUp
{
    NSString *username = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirmPassword = [self.confirmPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (username.length == 0 || password.length == 0 || confirmPassword.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid SignUp" message:@"Please enter information for all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
    
    else if (password.length < 6)
    {
        NSLog(@"Password too short");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password must be at least 6 characters" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        self.passwordTextField.text = nil;
        self.confirmPasswordTextField.text = nil;
        [self.passwordTextField becomeFirstResponder];
    }
    
    else if (![password isEqualToString:confirmPassword])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid SignUp" message:@"Passwords do not match.  Please reenter passwords" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        self.passwordTextField.text = nil;
        self.confirmPasswordTextField.text = nil;
    }
    else
    {
        [self saveToParse];
    }
}

//Validates that the email address sent is the correct format.
- (BOOL)validateEmailWithString:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// Alerts the user if something is wrong with the email that was entered in the field.  Check validity and unigueness.
- (void)emailValidationChecksForTextField:(UITextField *)textField
{
    if (self.emailTextField.text.length != 0) {
        if ([self validateEmailWithString:textField.text])
        {
            [self isUsernameTaken];
            NSLog(@"Valid");
        }
        else
        {
            NSLog(@"Not Valid");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alertView show];
        }
    }
    else
    {
        return;
    }
    

}

//Queris to see if the username/email address is taken
- (void)isUsernameTaken
{
    NSLog(@"Did call isUserNameTaken");
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" containsString:self.emailTextField.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Email query %@", objects);
        
        if ([objects count] != 0)
        {
            self.emailTakenLabel.hidden = NO;
        }
        else
        {
            self.emailTakenLabel.hidden = YES;
        }
    }];
}


//Saves the user to Parse.
- (void)saveToParse
{
    PFUser *newUser = [PFUser user];
    newUser.username = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;
    newUser.email = newUser.username;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have successfully registed for a user" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SingUp Error!" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            self.emailTextField.text = nil;
            self.passwordTextField.text = nil;
            self.confirmPasswordTextField.text = nil;
            [self.emailTextField becomeFirstResponder];
        }
    }];
}

@end
