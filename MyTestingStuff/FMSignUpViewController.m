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
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)signUpButtonPressed:(UIButton *)sender
{
    [self signUpUser];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField Delegates

/*
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
*/

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        if (![self validateEmailWithString:textField.text])
        {
            NSLog(@"Not Valid");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alertView show];
            
        }
        else
        {
            NSLog(@"Valid");
        }
    }
    self.currentResponder = nil;
}

#pragma mark - Helper Methods

- (void)resignOnTap:(id)sender
{
    [self.currentResponder resignFirstResponder];
}

- (void)signUpUser
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
        NSLog(@"SignUp!");
    }
}

- (BOOL)validateEmailWithString:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
