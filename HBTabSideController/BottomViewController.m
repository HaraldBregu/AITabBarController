//
//  BottomViewController.m
//  HBTabSideController
//
//  Created by harald bregu on 04/01/14.
//  Copyright (c) 2014 harald bregu. All rights reserved.
//

#import "BottomViewController.h"
#import "AITabBarController.h"

@interface BottomViewController ()

@end

@implementation BottomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(AITab *)tab
{
    AITab *tab = [[AITab alloc] init];
    tab.titleTab = @"Bottom";
    
    return tab;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
}

@end
