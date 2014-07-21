//
//  Constants.h
//  HBTabSideController
//
//  Created by harald bregu on 26/12/13.
//  Copyright (c) 2013 harald bregu. All rights reserved.
//


// Check device interface
#define DEVICE_INTERFACE_iPAD UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad
#define DEVICE_INTERFACE_iPHONE UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone


// Check Version
#define VERSION_DEVICE_PREFIX(x) [[[UIDevice currentDevice] systemVersion] hasPrefix:x]
#define VERSION_DEVICE_LOWER_THAN(x) ([[[UIDevice currentDevice] systemVersion] floatValue] < x)

#define VERSION_GREATER_THAN_6_1 NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1
#define VERSION_LESS_THAN_6_1 NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1



