//
//  AITabBar.m
//  HBTabSideController
//
//  Created by harald bregu on 26/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import "AITabBar.h"
#import "AITabBarController_Constants.h"

@interface AITabBar ()

@property (nonatomic, strong, readonly) NSArray * allTabs;

@end

@implementation AITabBar

#pragma mark - Initializers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeRedraw;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
    }
    return self;
}

#pragma mark - Setters and Getters

-(void)setTopPrincipalTab:(AITab *)topPrincipalTab
{
    if (_topPrincipalTab != topPrincipalTab) {
        [_topPrincipalTab removeFromSuperview];
        
        _topPrincipalTab = topPrincipalTab;
        
        // Add actions if you want
        _topPrincipalTab.userInteractionEnabled = NO;
    }
}


-(void)setTopTabs:(NSArray *)topTabs
{
    if (_topTabs != topTabs) {
        
        for (AITab *tab in _topTabs) {
            [tab removeFromSuperview];
        }
        
        _topTabs = topTabs;
        
        for (AITab *tab in _topTabs) {
            tab.userInteractionEnabled = YES;
            [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchDown];
        }
    }
}

-(void)setBottomTabs:(NSArray *)bottomTabs
{
    if (_bottomTabs != bottomTabs) {
        
        for (AITab *tab in _bottomTabs) {
            [tab removeFromSuperview];
        }
        
        _bottomTabs = bottomTabs;
        
        for (AITab *tab in _bottomTabs) {
            tab.userInteractionEnabled = YES;
            [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchDown];
        }
    }
}

-(NSArray *)allTabs
{
    return [_topTabs arrayByAddingObjectsFromArray:_bottomTabs];
}

-(void)setSelectedTab:(AITab *)selectedTab
{
    if (_selectedTab != selectedTab) {
        [_selectedTab setSelected:NO];
        _selectedTab = selectedTab;
        [_selectedTab setSelected:YES];
    }
}

#pragma mark - Private methods
-(void)tabSelected:(AITab *)sender
{
    // The selected index
    NSUInteger index = [self.allTabs indexOfObject:sender];
    
    // Select the tab when is touched
    self.selectedTab = [self.allTabs objectAtIndex:index];
    
    // Delegate a tab when is touched at index
    [self.delegate tabBar:self didSelectTabAtIndex:index];
    
    // A block for the selected tab
    if (self.selectionTab != NULL) {
        self.selectionTab (index);
    }
}


#pragma mark - Drawing 
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    /* Background color */
    [[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0] set];
    //[[UIColor redColor] set];
    CGContextFillRect(context, rect);
    
    
    
    // Drawing the edge border lines
    /*CGContextSetFillColorWithColor(context,[[UIColor grayColor] CGColor]);
    
    for (AITab *tab in _topTabs) {
        
        CGContextFillRect(context, CGRectMake(2, CGRectGetMaxY(tab.frame), tab.frame.size.width - 4, 1));
    }
    
    // Drawing the edge border lines
    CGContextSetFillColorWithColor(context,[[UIColor grayColor] CGColor]);
    
    for (AITab *tab in _bottomTabs) {
        
        CGContextFillRect(context, CGRectMake(2, CGRectGetMinY(tab.frame)-1, tab.frame.size.width - 4, 1));
    }*/
}


#pragma mark - Laying out subviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat tabWidth = self.bounds.size.width;
    
    
    if (VERSION_GREATER_THAN_6_1) {
        !_topMargin ? _topMargin = 20 : _topMargin;
    }
    if (VERSION_LESS_THAN_6_1) {
        !_topMargin ? _topMargin = 0 : _topMargin;
    }
    
    !_topTabHeight ? _topTabHeight = 44 : _topTabHeight;
    
    
    
    // Top principal tab
    _topPrincipalTab.frame = CGRectMake(rect.origin.x, rect.origin.y + _topMargin, rect.size.width, _topTabHeight);
    [self addSubview:_topPrincipalTab];


    CGFloat otherTabsY = self.bounds.origin.y + _topPrincipalTab.frame.size.height + _topMargin;
    // Top tabs frame
    for (AITab *tab in _topTabs) {
        
        if ([_topTabs indexOfObject:tab] == 0) {
            tab.frame = CGRectMake(rect.origin.x, otherTabsY, rect.size.width, tabWidth);
        } else {
            tab.frame = CGRectMake(rect.origin.x, otherTabsY, rect.size.width, tabWidth);
        }
        [self addSubview:tab];
        otherTabsY = otherTabsY + tab.frame.size.height;
    }
    
    
    CGFloat bottomY = CGRectGetMaxY(self.bounds) - (tabWidth * _bottomTabs.count);
    // Bottom tabs frame
    for (AITab *tab in _bottomTabs) {
        
        if ([_bottomTabs indexOfObject:tab] == 0) {
            tab.frame = CGRectMake(rect.origin.x, bottomY, rect.size.width, tabWidth);
        } else {
            tab.frame = CGRectMake(rect.origin.x, bottomY, rect.size.width, tabWidth);
        }
        [self addSubview:tab];
        bottomY = bottomY + tab.frame.size.height;
    }
}

@end
