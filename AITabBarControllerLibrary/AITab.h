//
//  AITab.h
//  HBTabSideController
//
//  Created by harald bregu on 25/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AITab : UIControl

@property (nonatomic, strong) NSString *titleTab;
@property (nonatomic, strong) UIImage *tabIcon;
@property (nonatomic, strong) UIColor *backgroundTabColor;
@property (nonatomic, strong) UIColor *backgroundSelectedTabColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) NSArray *iconColors;
@property (nonatomic, strong) NSArray *selectedIconColors;
@property (nonatomic, assign) BOOL fullTab;

@end
