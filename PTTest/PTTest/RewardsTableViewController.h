//
//  RewardsTableViewController.h
//  PTTest
//
//  Created by Ben Nichols on 10/18/11.
//  Copyright (c) 2011 PunchTab, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTController.h"

@interface RewardsTableViewController : UITableViewController <PTControllerDelegate>

@property (nonatomic, retain) NSArray * rewardsData;
@property (nonatomic, retain) PTController * ptController;

@end
