//
//  FMViewController.m
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/8/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMViewController.h"

@interface FMViewController ()

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
