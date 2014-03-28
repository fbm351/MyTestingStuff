//
//  FMLogOutViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/27/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMLogOutViewController.h"

@interface FMLogOutViewController ()

@property (nonatomic) UIView *alertView;
@property (nonatomic) UIDynamicAnimator *animator;

@end

@implementation FMLogOutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGPoint centerPoint = CGPointMake(self.view.center.x, self.view.center.y - 50);
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.alertView snapToPoint:centerPoint];
    [self.animator addBehavior:snap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

- (void)setupView
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.85];
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0.0, -320.0, 300.0f, 110.0f)];
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.layer.cornerRadius = 5;
    self.alertView.layer.masksToBounds = YES;
    [self.view addSubview:self.alertView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Are you sure?";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [label sizeToFit];
    float viewWidth = self.alertView.frame.size.width;
    //float viewHeight = self.alertView.frame.size.height;
    float labelWidth = label.frame.size.width;
    float labelHeight = label.frame.size.height;
    float labelXPos = (viewWidth / 2.0f) - (labelWidth / 2.0f);
    //float labelYPos = (viewHeight / 2.0f) - (labelHeight / 2.0f);
    
    [label setFrame:CGRectMake(labelXPos, 10, labelWidth, labelHeight)];
    [self.alertView addSubview:label];
    
    //Logout Button View
    UIView *logOutButtonView = [[UIView alloc] initWithFrame:CGRectMake(149, 55, 150, 55)];
    logOutButtonView.backgroundColor = [UIColor clearColor];
    logOutButtonView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    logOutButtonView.layer.borderWidth = 0.5f;
    [self.alertView addSubview:logOutButtonView];
    
    //Cancel Button View
    UIView *cancelButtonView = [[UIView alloc] initWithFrame:CGRectMake(-1, 55, 151, 55)];
    cancelButtonView.backgroundColor = [UIColor clearColor];
    cancelButtonView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancelButtonView.layer.borderWidth = 0.5f;
    [self.alertView addSubview:cancelButtonView];
    
    
    //Logout Button
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutButton.frame = CGRectMake(-1, 0, 151, 55);
    [logOutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    [logOutButton setTag:1];
    [logOutButton setTitleColor:logOutButton.tintColor forState:UIControlStateNormal];
    [logOutButton setTitleColor:logOutButton.tintColor forState:UIControlStateSelected];
    [logOutButton setTitleColor:logOutButton.tintColor forState:UIControlStateHighlighted];
    [logOutButton addTarget:self action:@selector(changeButtonBackgroundColor:) forControlEvents:UIControlEventTouchDown];
    [logOutButton addTarget:self action:@selector(resetButtonBackgroundColor:) forControlEvents:UIControlEventTouchUpInside];
    [logOutButton addTarget:self action:@selector(resetButtonBackgroundColorOnCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [logOutButtonView addSubview:logOutButton];
    
    //Cancel Button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(-1, 0, 151, 55);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTag:2];
    [cancelButton setTitleColor:cancelButton.tintColor forState:UIControlStateNormal];
    [cancelButton setTitleColor:cancelButton.tintColor forState:UIControlStateSelected];
    [cancelButton setTitleColor:cancelButton.tintColor forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(changeButtonBackgroundColor:) forControlEvents:UIControlEventTouchDown];
    [cancelButton addTarget:self action:@selector(resetButtonBackgroundColor:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(resetButtonBackgroundColorOnCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [cancelButtonView addSubview:cancelButton];

    
}

- (void)changeButtonBackgroundColor:(UIButton *)sender
{
    [sender setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
}

- (void)resetButtonBackgroundColor:(UIButton *)sender
{
    [sender setBackgroundColor:[UIColor clearColor]];
    
    if (sender.tag == 1) {
        NSLog(@"Pressed Logout");
        [self.animator removeAllBehaviors];
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.alertView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
        [self.animator addBehavior:snap];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.animator removeAllBehaviors];
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.alertView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
        [self.animator addBehavior:snap];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)resetButtonBackgroundColorOnCancel:(UIButton *)sender
{
    [sender setBackgroundColor:[UIColor clearColor]];
    
}

@end
