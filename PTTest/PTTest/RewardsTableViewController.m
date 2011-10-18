//
//  RewardsTableViewController.m
//  PTTest
//
//  Created by Ben Nichols on 10/18/11.
//  Copyright (c) 2011 PunchTab, Inc. All rights reserved.
//

#import "RewardsTableViewController.h"

@interface RewardsTableViewController ()

@property (nonatomic, retain) NSMutableArray * sections;

@end

@implementation RewardsTableViewController

@synthesize sections = _sections;
@synthesize rewardsData = _rewardsData;
@synthesize ptController = _ptController;

- (void)setRewardsData:(NSArray *)rewardsData 
{
    NSSortDescriptor * sort1 = [[[NSSortDescriptor alloc] initWithKey:@"brand" ascending:YES] autorelease]; 
    NSSortDescriptor * sort2 = [[[NSSortDescriptor alloc] initWithKey:@"points" ascending:NO] autorelease]; 
    NSArray * sortedData = [rewardsData sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sort1, sort2, nil]];
    
    NSMutableArray * currentSection = nil;
    NSString * currentBrand = nil;
    for (NSDictionary * dict in sortedData) 
    {
        NSString * brand = [dict objectForKey:@"brand"];
        if (![brand isEqualToString:currentBrand]) 
        {
            if (currentSection) 
            {
                [_sections addObject:currentSection];
            }
            currentSection = [NSMutableArray arrayWithCapacity:3];
            currentBrand = brand;
        }
        [currentSection addObject:dict];
    }
    if (currentSection) 
    {
        [_sections addObject:currentSection];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.sections = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)dealloc
{
    self.sections = nil;
    self.ptController = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Rewards";
    self.ptController.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionList = [_sections objectAtIndex:section];
    return sectionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary * cellData = [[_sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [cellData objectForKey:@"name"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [cellData objectForKey:@"points"]];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray * sectionList = [_sections objectAtIndex:0];
    NSDictionary * reward = [sectionList objectAtIndex:0];
    return [reward objectForKey:@"brand"];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber * rewardId = [[[_sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"reward_id"];
    [_ptController redeemReward:rewardId];
}

- (void)activityFinished:(NSDictionary *)response 
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
