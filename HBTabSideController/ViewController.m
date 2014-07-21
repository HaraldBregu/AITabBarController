//
//  ViewController.m
//  HBTabSideController
//
//  Created by harald bregu on 15/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import "ViewController.h"
#import "AITabBarController.h"
#import <objc/runtime.h>

//#import "UIViewController+AddProperty.h"


@interface ViewController () 
{
    
    UIView *view;
}

@end

@implementation ViewController



-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}


-(AITab *)tab
{
    AITab *tb = [[AITab alloc] init];
    tb.titleTab = @"TAB Nav";
    tb.tabIcon = [UIImage imageNamed:@"man"];
    return tb;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Ti First";
    self.navigationItem.title = @"Nv First";
    
    NSLog(@"First VC");
    
    
    //AITab *tb = [[AITab alloc] init];
    //tb.titleTab = @"Tab";
    
    //self.aiTabBarController.tabItem.titleTab = @"TAB";
    
//    view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    view.frame = CGRectMake(CGRectGetMaxX(self.view.bounds) - 50, 100, 50, 50);
//    view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 60, 60);
    [btn setTitle:@"Show" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(showTabBar) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton*btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(100, 180, 60, 60);
    [btn2 setTitle:@"Hide" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(hideTabBar) forControlEvents:UIControlEventTouchUpInside];


}

-(void)showTabBar
{
    [self.aiTabBarController showAfter:0.0 andHide:YES after:2];
}

-(void)hideTabBar
{
    [self.aiTabBarController hideAfter:0.0];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    


    
    //NSLog(@"did appear First");
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    

    //NSLog(@"Appear with rect %@", NSStringFromCGRect(self.view.frame));

}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //NSLog(@"will rotate");
}


@end
