//
//  AITabBarViewController.h
//  HBTabSideController
//
//  Created by harald bregu on 28/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//


#import "AITabBar.h"
#import "AITab.h"

typedef NS_ENUM(NSUInteger, AITabBarStyle) {
    AITabBarStyleFixed,
    AITabBarStyleSlidingLeft,
};


@interface AITabBarController : UIViewController

-(id)initWithTabBarStyle:(AITabBarStyle)tabBarStyle;
@property (nonatomic) CGFloat tabBarWidth;

@property (nonatomic, copy) NSArray *primaryControllers;
@property (nonatomic, copy) NSArray *secondaryControllers;

@property (nonatomic, assign) UIViewController *selectedViewController;

@property (nonatomic, readonly, getter = tabBarIsHidden) BOOL tabBarHiden;
-(void)showAfter:(NSTimeInterval)time andHide:(BOOL)hide after:(NSTimeInterval)hideTime;
-(void)hideAfter:(NSTimeInterval)time;

@end



@interface UIViewController (AITabBarController)

@property (nonatomic, strong,readonly) AITabBarController *aiTabBarController;

-(AITab *)tab;

@end

@interface UINavigationController (AITabBarController)

-(AITab *)tab;

@end