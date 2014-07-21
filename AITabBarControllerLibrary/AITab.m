//
//  AITab.m
//  HBTabSideController
//
//  Created by harald bregu on 25/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//

#import "AITab.h"
#import "AITabBarController_Constants.h"


// Padding of the content
static const float kPadding = 4.0;
// Margin between icon and title
static const float kMargin = 2;

@interface AITab () {

}
@end

@implementation AITab

- (id)init
{
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Get the context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Base container rectangle
    CGFloat containerWH = MIN(rect.size.width, rect.size.height);    
    CGFloat containerXpoint = CGRectGetMidX(rect) - containerWH/2;
    CGFloat containerYpoint = CGRectGetMidY(rect) - containerWH /2;
    CGRect baseContainerRect = CGRectMake(containerXpoint, containerYpoint, containerWH, containerWH);
    
    // Container rectangle
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(kPadding + 2, kPadding, kPadding, kPadding);
    CGRect containerRect = UIEdgeInsetsInsetRect(baseContainerRect, contentInsets);
    CGFloat widthOrHeightContainer = containerRect.size.height;
    
    // Set the TitleTab rect
    CGFloat heightTitle = round(widthOrHeightContainer / 3.6);
    CGRect titleRect = CGRectMake(containerRect.origin.x, CGRectGetMaxY(containerRect) - heightTitle, containerRect.size.width, heightTitle);
    
    // Set the Icon rect
    CGFloat heightIcon = widthOrHeightContainer - heightTitle - kMargin;
    CGPoint iconPoint = CGPointMake(CGRectGetMidX(containerRect) - (heightIcon/2), containerRect.origin.y);
    CGSize iconSize = CGSizeMake(heightIcon, heightIcon);
    CGRect iconRect = CGRectMake(iconPoint.x, iconPoint.y, iconSize.width, iconSize.height);
    
    if (!_tabIcon && _titleTab) {
        
        titleRect = CGRectMake(containerRect.origin.x, CGRectGetMidY(containerRect) - heightTitle/2 , containerRect.size.width, containerRect.size.height);
    }
    if (_tabIcon && !_titleTab) {
    
        if (_fullTab) {
            
            iconRect = CGRectMake(containerXpoint, containerYpoint, containerWH, containerWH);
        }
        if (!_fullTab) {
            iconRect = CGRectMake(containerRect.origin.x, containerRect.origin.y, widthOrHeightContainer, widthOrHeightContainer);
        }
    }
    
    
    
    ///////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////**** Drawing ****/////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////
    
    UIColor *backgroundTabColor;
    UIColor *textColor;
    NSArray *iconColors;
    
    if (!self.selected) {
        
        self.userInteractionEnabled = YES;
        backgroundTabColor = !_backgroundTabColor ? _backgroundTabColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]: _backgroundTabColor;
        textColor = !_textColor ? _textColor = [UIColor colorWithRed:0.461 green:0.461 blue:0.461 alpha:1.0]: _textColor;
        NSArray *colors = @[(id)[UIColor colorWithRed:0.353 green:0.353 blue:0.353 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.612 green:0.612 blue:0.612 alpha:1.0].CGColor];
        iconColors = !_iconColors ? colors : _iconColors;
    }
    else if (self.selected) {
        
        //NSLog(@"selected");
        //TODO
        self.userInteractionEnabled = NO;
        backgroundTabColor = !_backgroundSelectedTabColor ? _backgroundSelectedTabColor = [UIColor grayColor] : _backgroundSelectedTabColor;
        textColor = !_selectedTextColor ? _selectedTextColor = [UIColor whiteColor]: _selectedTextColor;
        NSArray *colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor redColor].CGColor];
        iconColors = !_selectedIconColors ? colors : _selectedIconColors;
    }
    
    /* We fill the background with a noise pattern */
    CGContextSaveGState(context);
    {
        [backgroundTabColor set]; // the tab color
        CGContextFillRect(context, rect);
        
        // We set the parameters of th gradient multiply blend
        /*size_t num_locations = 2;
        CGFloat locations[2] = {1.0, 0.0};
        CGFloat components[8] = {0.6, 0.6, 0.6, 1.0,  // Start color
            0.2, 0.2, 0.2, 0.4}; // End color
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //CGGradientRef gradient = _tabSelectedColors ? CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)_tabSelectedColors, locations) : CGGradientCreateWithColorComponents (colorSpace, components, locations, num_locations);
        CGGradientRef gradient = CGGradientCreateWithColorComponents (colorSpace, components, locations, num_locations);
        CGContextSetBlendMode(context, kCGBlendModeMultiply);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, 50), kCGGradientDrawsAfterEndLocation);
        
        
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);*/
    } CGContextRestoreGState(context);
    
    /* Draw the title of the tab */
   CGContextSaveGState(context);
    {
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:heightTitle];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingMiddle;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName: paragraphStyle,
                                     NSForegroundColorAttributeName: textColor,
                                     NSFontAttributeName: font};
       
        if (VERSION_LESS_THAN_6_1) {

            CGContextSetFillColorWithColor(context, textColor ? textColor.CGColor : textColor.CGColor);
            [_titleTab drawInRect:titleRect withFont:font lineBreakMode:NSLineBreakByTruncatingMiddle  alignment:NSTextAlignmentCenter];
        }
        else if (VERSION_GREATER_THAN_6_1) {
            
            _titleTab ? [_titleTab drawInRect:titleRect withAttributes:attributes] : nil;
        }
    }
    CGContextRestoreGState(context);
    
    /* We draw the inner gradient */
    CGContextSaveGState(context);
    {
        if (!_fullTab) {

            CGFloat offsetY = rect.size.height - (_titleTab ? (kMargin + CGRectGetHeight(titleRect)):0) + kMargin;
            
            CGContextTranslateCTM(context, 0.0, offsetY);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextClipToMask(context, iconRect, _tabIcon.CGImage);

            //size_t num_locations = 2;
            CGFloat locations[2] = {1.0, 0.0};
            //CGFloat components[8] = {0.353, 0.353, 0.353, 1.0, // Start color
            //0.612, 0.612, 0.612, 1.0};  // End color
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            
            
            
            CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(iconColors), locations);
            
            //CGGradientCreateWithColorComponents (colorSpace, components, locations, num_locations);
            CGPoint startPoint = CGPointMake(CGRectGetMidX(iconRect), CGRectGetMinY(iconRect));
            CGPoint endPoint = CGPointMake(CGRectGetMidX(iconRect), CGRectGetMaxY(iconRect));
            
            _tabIcon ? CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation) : 0;
            
            CGColorSpaceRelease(colorSpace);
            CGGradientRelease(gradient);
        }
        
        if (_fullTab) {
            
            [_tabIcon drawInRect:iconRect];
        }
    }
    CGContextRestoreGState(context);
  
    
}
@end
