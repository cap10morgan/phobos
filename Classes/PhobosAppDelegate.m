//
//  PhobosAppDelegate.m
//  Phobos
//
//  Created by Wes Morgan on 7/26/10.
//  Copyright (c) 2010 Democratic National Committee. All rights reserved.
//


#import "PhobosAppDelegate.h"

#import "MainViewController.h"

@implementation PhobosAppDelegate


@synthesize window;

@synthesize mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
    // Add the main view controller's view to the window and display.
    [window addSubview:mainViewController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}

- (void)dealloc {

    [window release];
    [mainViewController release];
    [super dealloc];
}

@end

