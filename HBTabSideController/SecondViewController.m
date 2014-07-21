//
//  SecondViewController.m
//  HBTabSideController
//
//  Created by harald bregu on 29/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import "SecondViewController.h"
#import "AITabBarController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //self.title = @"Add";
        
        //NSLog(@"init");

    }
    return self;
}

//-(NSString *)tabTitle {
//    
//    return @"tb title 2";
//}


-(AITab *)tab
{
    AITab *tb = [[AITab alloc] init];
    tb.titleTab = @"TAB 2";
    tb.tabIcon = [UIImage imageNamed:@"plus.png"];
    
    return tb;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Ti Second";
    self.navigationItem.title = @"Nv Secnd";
    
//    AITab *tb = [[AITab alloc] init];
//    tb.titleTab = @"TAB";
//    [self setTab:tb];

    
    NSLog(@"Second VC");

    

}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //NSLog(@"Appear");
    
    //NSLog(@"did appear second");

}


@end
