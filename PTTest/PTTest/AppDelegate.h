//
//  AppDelegate.h
//  PTTest
//
//  Created by Ben Nichols on 10/18/11.
//  Copyright (c) 2011 PunchTab, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTController.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;

@property (nonatomic, retain) PTController * ptController;

@end
