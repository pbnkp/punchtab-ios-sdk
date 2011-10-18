//
//  ViewController.m
//  PTTest
//
//  Created by Ben Nichols on 10/18/11.
//  Copyright (c) 2011 PunchTab, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "LeaderboardTableViewController.h"
#import "RewardsTableViewController.h"

@interface MainViewController ()

- (void)setLoggedInState; 
- (void)setLoggedOutState; 

@end

@implementation MainViewController

@synthesize loginButton = _loginButton;
@synthesize logoutButton = _logoutButton;
@synthesize pointsButton = _pointsButton;
@synthesize leaderboardButton = _leaderboardButton;
@synthesize rewardsButton = _rewardsButton;
@synthesize ptController = _ptController;

- (void)setPtController:(PTController *)ptController 
{
    [ptController retain];
    [_ptController release];
    _ptController = ptController;
    
    if (self.ptController.delegate == nil) {
        self.ptController.delegate = self;
    }    
}

#pragma mark Cleanup

- (void)unloadUI
{
    self.loginButton = nil;
    self.logoutButton = nil;
    self.pointsButton = nil;
    self.leaderboardButton = nil;
    self.rewardsButton = nil;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self unloadUI];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.ptController = nil;
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"PTTest";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLoggedInState) name:kPTLoginNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self unloadUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.ptController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark IBActions

- (void)loginButtonPressed:(id)sender 
{
    [_ptController login];  
}

- (IBAction)logoutButtonPressed:(id)sender
{
    [_ptController logout];
}

- (IBAction)pointsButtonPressed:(id)sender 
{
    [_ptController sendActivity:@"tweet"];
}

- (IBAction)leaderboardButtonPressed:(id)sender
{
    [_ptController getLeaderboardWithMe:YES]; 
}

- (IBAction)rewardsButtonPressed:(id)sender
{
    [_ptController getRewards];
}

#pragma mark Private methods

- (void)setLoggedInState 
{
    self.logoutButton.hidden = NO;
    self.loginButton.hidden = YES;
    self.pointsButton.hidden = NO;
    self.leaderboardButton.hidden = NO;
    self.rewardsButton.hidden = NO;    
}

- (void)setLoggedOutState 
{
    self.logoutButton.hidden = YES;
    self.loginButton.hidden = NO;
    self.pointsButton.hidden = YES;
    self.leaderboardButton.hidden = YES;
    self.rewardsButton.hidden = YES;    
}

#pragma mark PTControllerDelegate

- (void)loginFinished:(NSDictionary *)response 
{    
    [self setLoggedInState];
}

- (void)logoutFinished:(NSDictionary *)response 
{
    [self setLoggedOutState];
}

- (void)receivedLeaderboard:(NSDictionary *)response 
{
    if ([[response objectForKey:kPTResponseStatusCode] intValue] == 200) 
    {
        LeaderboardTableViewController * tableVC = [[[LeaderboardTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        tableVC.leaderboardData = [response objectForKey:kPTResponseObject];
        [self.navigationController pushViewController:tableVC animated:YES];
    }    
}

- (void)receivedRewards:(NSDictionary *)response 
{
    if ([[response objectForKey:kPTResponseStatusCode] intValue] == 200) 
    {
        RewardsTableViewController * tableVC = [[[RewardsTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        tableVC.rewardsData = [response objectForKey:kPTResponseObject];
        tableVC.ptController = _ptController;
        [self.navigationController pushViewController:tableVC animated:YES];
    }    
}

- (void)activityFinished:(NSDictionary *)response 
{    
    [_ptController getUserData];
}

@end
