//
//  AITabBar.h
//  HBTabSideController
//
//  Created by harald bregu on 26/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import "AITab.h"

@class AITabBar;

@protocol AITabBarDelegate <NSObject>

@required
-(void)tabBar:(AITabBar *)tabBar didSelectTabAtIndex:(NSUInteger)indexTab;

@end

@interface AITabBar : UIView

@property (nonatomic) CGFloat topMargin;
@property (nonatomic) CGFloat topTabHeight;

@property (nonatomic, strong) AITab *topPrincipalTab;
@property (nonatomic, copy) NSArray *topTabs;
@property (nonatomic, copy) NSArray *bottomTabs;
@property (nonatomic, assign) AITab *selectedTab;

@property (nonatomic,copy) void(^selectionTab)(NSUInteger index);
@property (nonatomic, assign) id<AITabBarDelegate>delegate;

@end
