//
//  FMLogOutViewController.h
//  MyTestingStuff
//
//  Created by Fredrick Myers on 3/27/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMLogOutViewControllerDelegate <NSObject>

@required

- (void)didPressLogOutButton;

@end

@interface FMLogOutViewController : UIViewController

@property (weak, nonatomic) id<FMLogOutViewControllerDelegate>delegate;

@end
