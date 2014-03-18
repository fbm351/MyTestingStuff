//
//  FMLoginViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/8/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMLoginViewController.h"

@interface FMLoginViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (assign, nonatomic) id currentResponder;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UILabel *emailSentLabel;

@end

@implementation FMLoginViewController

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
    [self.emailSentLabel setAlpha:0.0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    [self signInUser];
}


#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentResponder = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentResponder = textField;
}

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"User before Email update %@", [PFUser currentUser]);
        [[PFUser currentUser] setObject:@"reset@reset.com" forKey:@"email"];
        [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [[PFUser currentUser] setObject:self.emailTextField.text forKey:@"email"];
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [PFUser logOut];
                NSLog(@"User after Email update %@", [PFUser currentUser]);
                self.passwordTextField.text = nil;
                [self.passwordTextField resignFirstResponder];
                [self showThenFadeLabel:self.emailSentLabel];

            }];
        }];
    }
}

#pragma mark - Helper Methods

- (void)resignOnTap:(id)sender
{
    [self.currentResponder resignFirstResponder];
}

- (void)signInUser
{
    if (self.emailTextField.text.length == 0 || self.passwordTextField.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Login" message:@"Please enter information for all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        [self parseLogin];
    }
}

- (void)parseLogin
{
    [PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        BOOL isEmailVerified = [user[@"emailVerified"] boolValue];
        if (!error)
        {
            if (user && isEmailVerified == YES)
            {
                NSLog(@"User Signed in");
                NSLog(@"Email Verified %@", user[@"emailVerified"]);
            }
            else if (!isEmailVerified)
            {
                //NSLog(@"User Valid but email not verified");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Verify Email" message:[NSString stringWithFormat:@"This email address ( %@ ) must be verified before login.", self.emailTextField.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Resend Email", nil];
                [alertView show];
            }
            else
            {
                NSString *errorString = [error userInfo][@"error"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error!" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }
        else
        {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error!" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
            
        
    }];
}

- (void)showThenFadeLabel:(UILabel *)label
{
    [label setAlpha:1.0];
    [UIView animateWithDuration:1.0 delay:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [label setAlpha:0.0];
    } completion:^(BOOL finished) {
        if (finished)
        {
            NSLog(@"Animation Done");
        }
    }];
}

@end
