//
//  AppDelegate.m
//  HBTabSideController
//
//  Created by harald bregu on 15/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import "AppDelegate.h"
#import "AITabBarController_Constants.h"

#import "ViewController.h"
#import "SecondViewController.h"

#import "BottomViewController.h"

#import "AITabBarController.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //ViewController *first = [mainStoryboard instantiateViewControllerWithIdentifier:@"first"];
    //first.title = @"Home";
    UINavigationController *navFirst = [mainStoryboard instantiateViewControllerWithIdentifier:@"navFirst"];
    //navFirst.navigationItem.title = @"Nav 1";
    
    SecondViewController *second = [mainStoryboard instantiateViewControllerWithIdentifier:@"second"];
    //second.title = @"Sec";
    
    //UIViewController *thirdVC = [[UIViewController alloc] init];
    //thirdVC.view.backgroundColor = [UIColor brownColor];
    
    BottomViewController *bottom1 = [[BottomViewController alloc] init];
    //bottom1.view.backgroundColor = [UIColor greenColor];
    
    
    AITabBarController *tbViewc;
    if (DEVICE_INTERFACE_iPAD) {
        tbViewc = [[AITabBarController alloc] initWithTabBarStyle:AITabBarStyleFixed];
        tbViewc.tabBarWidth = 44;
    }
    if (DEVICE_INTERFACE_iPHONE) {
        
        tbViewc = [[AITabBarController alloc] initWithTabBarStyle:AITabBarStyleSlidingLeft];
        tbViewc.tabBarWidth = 44;
    }
    
    tbViewc.primaryControllers = @[navFirst, second];
    tbViewc.secondaryControllers = @[bottom1];
    
    tbViewc.selectedViewController = navFirst;
    
    self.window.rootViewController = tbViewc;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
