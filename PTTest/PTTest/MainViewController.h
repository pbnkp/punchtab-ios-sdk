//
//  ViewController.h
//  PTTest
//
//  Created by Ben Nichols on 10/18/11.
//  Copyright (c) 2011 PunchTab, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTController.h"

@interface MainViewController : UIViewController <PTControllerDelegate>

@property (nonatomic, retain) IBOutlet UIButton * loginButton;
@property (nonatomic, retain) IBOutlet UIButton * logoutButton;
@property (nonatomic, retain) IBOutlet UIButton * pointsButton;
@property (nonatomic, retain) IBOutlet UIButton * leaderboardButton;
@property (nonatomic, retain) IBOutlet UIButton * rewardsButton;

@property (nonatomic, retain) PTController * ptController;

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)logoutButtonPressed:(id)sender;
- (IBAction)pointsButtonPressed:(id)sender;
- (IBAction)leaderboardButtonPressed:(id)sender;
- (IBAction)rewardsButtonPressed:(id)sender;

@end
