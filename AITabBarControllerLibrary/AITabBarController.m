///
//  AITabBarViewController.m
//  HBTabSideController
//
//  Created by harald bregu on 28/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import "AITabBarController.h"
#import <objc/runtime.h>

@interface AITabBarController () <AITabBarDelegate>
{
    UIView *containerView;
    UIPanGestureRecognizer *panGesture;
    
    NSTimer *timer;
}

@property (nonatomic) AITabBarStyle tabBarStyle;
@property (nonatomic, strong) AITabBar *tabBar;

// Private utilities methods
-(void)moveContainerRectOutWithAnimation:(BOOL)animated;
-(void)moveContainerRectInWithAnimation:(BOOL)animated;
-(void)addChildViewAtIndex:(NSUInteger)index toConteinerView:(UIView *)containerV;

@end

@implementation AITabBarController

#pragma mark - Initialization methods
- (id)initWithTabBarStyle:(AITabBarStyle)tabBarStyle
{
    self = [super init];
    if (self) {
        
        self.tabBarStyle = tabBarStyle;
        
        containerView = [[UIView alloc] init];
        containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tabBar = [[AITabBar alloc] init];
        _tabBar.delegate = self;
        panGesture = [[UIPanGestureRecognizer alloc] init];
        
    }
    return self;
}

#pragma mark - Managing view methods
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (_tabBarStyle) {
        case AITabBarStyleFixed:
            containerView.frame = CGRectMake(_tabBarWidth, self.view.bounds.origin.y, self.view.bounds.size.width - _tabBarWidth, self.view.bounds.size.height);
            _tabBar.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, _tabBarWidth, self.view.bounds.size.height);
            
            panGesture.enabled = NO;
            break;
            
        case AITabBarStyleSlidingLeft:
            containerView.frame = self.view.bounds;
            _tabBar.frame = CGRectMake(-_tabBarWidth, self.view.bounds.origin.y, _tabBarWidth, self.view.bounds.size.height);
            
            panGesture.enabled = YES;
            
            break;
        default:
            break;
    }
    
    // Container View
    [self.view addSubview:containerView];
    
    // Tab Bar
    [self.view addSubview:_tabBar];
    
    // Gesture
    [panGesture addTarget:self action:@selector(pan:)];
    [containerView addGestureRecognizer:panGesture];
    
    AITab *topTab = [[AITab alloc] init];
    topTab.fullTab = YES;
    topTab.tabIcon = [UIImage imageNamed:@"Atom.png"];
    _tabBar.topPrincipalTab = topTab;
}

#pragma mark - Setters & Getters
-(void)setPrimaryControllers:(NSArray *)primaryControllers
{
    if (_primaryControllers != primaryControllers) {
        
        for (UIViewController *primaryVC in _primaryControllers) {
            [primaryVC willMoveToParentViewController:nil];
            [primaryVC.view removeFromSuperview];
            [primaryVC removeFromParentViewController];
        }
      
        _primaryControllers = primaryControllers;
        for (UIViewController *primaryVC in _primaryControllers) {
            
            // Add all view controllers in "primaryControllers" like child.
            [self addChildViewController:primaryVC];
            [primaryVC didMoveToParentViewController:self];
        }
        
        // Load top tabs
        NSMutableArray *tabs = [NSMutableArray array];
        for (UIViewController *primaryVC in _primaryControllers) {
            
            [tabs addObject:primaryVC.tab];
        }
        _tabBar.topTabs = tabs;
    }
}

-(void)setSecondaryControllers:(NSArray *)secondaryControllers
{
    if (_secondaryControllers != secondaryControllers) {
        
        for (UIViewController *secondaryVC in _secondaryControllers) {
            [secondaryVC willMoveToParentViewController:nil];
            [secondaryVC.view removeFromSuperview];
            [secondaryVC removeFromParentViewController];
        }
        
        _secondaryControllers = secondaryControllers;
        for (UIViewController *secondaryVC in _secondaryControllers) {
            
            // Add all view controllers in "secondaryControllers" like child.
            [self addChildViewController:secondaryVC];
            [secondaryVC didMoveToParentViewController:self];
        }
        
        // Load bottom tabs
        NSMutableArray *bTabs = [NSMutableArray array];
        for (UIViewController *secondaryVC in _secondaryControllers) {
            
            [bTabs addObject:secondaryVC.tab];
        }
        _tabBar.bottomTabs = bTabs;
    }
}

-(void)setSelectedViewController:(UIViewController *)selectedViewController
{
    _selectedViewController = selectedViewController;
    
    _selectedViewController.view.frame = containerView.bounds;
    _selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [containerView addSubview:_selectedViewController.view];
    
    NSUInteger selectedIndex = [_primaryControllers indexOfObject:self.selectedViewController];
    _tabBar.selectedTab  = [_tabBar.topTabs objectAtIndex:selectedIndex];

    // Optional
    /*
     // Add selected tab color like selected view controller view
    _tabBar.selectedTab.backgroundSelectedTabColor = _selectedViewController.view.backgroundColor;
     */
}

#pragma mark - AITabBar Delegate methods
-(void)tabBar:(AITabBar *)tabBar didSelectTabAtIndex:(NSUInteger)indexTab
{
    [self addChildViewAtIndex:indexTab toConteinerView:containerView];
    
    [timer invalidate];
   
    // Optional
    /*
     // Add selected tab color like selected view controller view
     UIViewController *vc = self.childViewControllers[indexTab];
    _tabBar.selectedTab.backgroundSelectedTabColor = vc.view.backgroundColor;
     */
}

#pragma mark - Gestures
-(void)pan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        /*CGPoint velocity = [gesture velocityInView:gesture.view];
         if (velocity.x < 0) {
         //NSLog(@"is smaller");
         } else if (velocity.x > 0){
         //NSLog(@"is bigger");
         }*/
        
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture translationInView:gesture.view];
        gesture.view.center =  CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y);
        [gesture setTranslation:CGPointZero inView:gesture.view];
        
        // First we create boundaries for the container rect
        CGRect containerRect = gesture.view.frame;
        (containerRect.origin.x < 0) ? (containerRect.origin.x = 0) : 0;
        (containerRect.origin.x > _tabBarWidth) ? (containerRect.origin.x = _tabBarWidth) : 0;
        gesture.view.frame = containerRect;
        
        CGPoint pTabBar = self.tabBar.center;
        pTabBar.x = gesture.view.frame.origin.x - (_tabBarWidth/2);
        self.tabBar.center = pTabBar;
        
        // Fire timer when pan gesture begin
        [timer setFireDate:[NSDate date]];
    }
    
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        if (gesture.view.center.x > self.view.center.x + (_tabBarWidth/2)) {
            
            _tabBarHiden = NO;
            //[timer setFireDate:[NSDate date]];
            // If gesture center is greater than half of the
            //babBar width, show container with animation
            [self moveContainerRectInWithAnimation:YES];
        }
        else if (gesture.view.center.x < self.view.center.x + (_tabBarWidth/2)) {
            
            _tabBarHiden = YES;
            //[timer setFireDate:[NSDate date]];
            // If gesture center is lower than half of the
            //babBar width, show container with animation
            [self moveContainerRectOutWithAnimation:YES];
        }
        
        //_tabBarHiden ? NSLog(@"hidden") : NSLog(@"show");
    }
}

#pragma mark - Animations
-(void)showAfter:(NSTimeInterval)time andHide:(BOOL)hide after:(NSTimeInterval)hideTime
{
    double delayInSeconds = time;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        (_tabBarStyle == AITabBarStyleSlidingLeft) ? [self moveContainerRectInWithAnimation:YES] : 0;
    });
    
    if (hide) {

        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:hideTime target:self selector:@selector(hideAfter:) userInfo:nil repeats:NO];
    }
}

-(void)hideAfter:(NSTimeInterval)time
{
    !time ? time = 0 : 0;
    
    double delayInSeconds = time;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        (_tabBarStyle == AITabBarStyleSlidingLeft) ? [self moveContainerRectOutWithAnimation:YES] : nil;
    });
    
    _tabBarHiden ? [timer setFireDate:[NSDate date]] : 0;
}

#pragma mark - Private methods
-(void)addChildViewAtIndex:(NSUInteger)index toConteinerView:(UIView *)containerV
{
    
    for (UIViewController *vc in self.childViewControllers) {
        [vc.view removeFromSuperview];
    }
    
    UIViewController *topViewController = self.childViewControllers[index];
    
    //this automatically calls view did/will disappear
    [topViewController.view removeFromSuperview];
    
    topViewController.view.frame = containerView.bounds;
    topViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //this automatically calls view did/will appear
    [containerV addSubview:topViewController.view];
}

-(void)moveContainerRectInWithAnimation:(BOOL)animated
{
    if (animated) {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect rec = _tabBar.frame;
            rec.origin.x = self.view.bounds.origin.x;
            _tabBar.frame = rec;
            
            CGRect cR = containerView.frame;
            cR.origin.x = _tabBarWidth;
            containerView.frame = cR;
            
            
        } completion:^(BOOL finished) {
            
            //_tabBarHiden = NO;
            //_tabBarHiden ? NSLog(@"hidden") : NSLog(@"show");
        }];
    }
}

-(void)moveContainerRectOutWithAnimation:(BOOL)animated
{
    if (animated) {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            CGRect rec = _tabBar.frame;
            rec.origin.x = -_tabBarWidth;
            _tabBar.frame = rec;
            
            CGRect cR = containerView.frame;
            cR.origin.x = self.view.bounds.origin.x;
            containerView.frame = cR;
            
            
        } completion:^(BOOL finished) {
            
            //_tabBarHiden = YES;
            //_tabBarHiden ? NSLog(@"hidden") : NSLog(@"show");
        }];
    }
}

@end


#pragma mark - UIViewController Category Implementation
@implementation UIViewController (AITabBarController)


-(AITabBarController *)aiTabBarController
{
    AITabBarController *aiTabBarController = nil;
    UIViewController *parentViewController = self.parentViewController;
    
    while (!aiTabBarController && parentViewController) {
        
        if ([parentViewController isKindOfClass:[AITabBarController class]])
            aiTabBarController = (AITabBarController *)parentViewController;
        else
            parentViewController = parentViewController.parentViewController;
    }
    return aiTabBarController;
}


-(AITab *)tab
{   
    return [[AITab alloc] init];
}

@end

#pragma mark - UIViewController Category Implementation
@implementation UINavigationController (AITabBarController)

-(AITab *)tab
{
    return [self.viewControllers[0] tab];
}

@end
