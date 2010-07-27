//
//  PhobosAppDelegate.h
//  Phobos
//
//  Created by Wes Morgan on 7/26/10.
//  Copyright (c) 2010 Democratic National Committee. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MainViewController;

@interface PhobosAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;

    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

