//
//  MainViewController.h
//  Phobos
//
//  Created by Wes Morgan on 7/26/10.
//  Copyright (c) 2010 Wes Morgan. All rights reserved.
//


#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    NSDictionary *versions;
    IBOutlet UILabel *latestVersion;
}

@property (nonatomic, retain) NSDictionary *versions;
@property (nonatomic, retain) IBOutlet UILabel *latestVersion;

- (IBAction)showInfo:(id)sender;

@end

