//
//  MainViewController.m
//  Phobos
//
//  Created by Wes Morgan on 7/26/10.
//  Copyright (c) 2010 Democratic National Committee. All rights reserved.
//


#import "MainViewController.h"
#import "AvailableVersions.h"

@implementation MainViewController

@synthesize versions, latestVersion;

- (void)viewDidLoad {
    latestVersion.font = [UIFont boldSystemFontOfSize:32.0];
    [self loadAvailableVersions];
	[super viewDidLoad];
}

- (void)loadAvailableVersions {
    if (versions == nil) {
        AvailableVersions *availableVersions = [[AvailableVersions alloc] init];
        [availableVersions loadAvailableVersionsWithDelegate:self];
        [availableVersions release];
    } else {
        NSLog(@"loadAvailableVersions was called, but we already have them");
    }
}

- (NSDictionary *)deviceDetails {
    UIDevice *thisDevice = [UIDevice currentDevice];
    NSLog(@"Got the device details");
	NSDictionary *deviceDict = [NSDictionary dictionaryWithObjectsAndKeys:
								[thisDevice systemVersion], @"systemVersion",
								[thisDevice platform], @"platform",
								nil];
    return deviceDict;
}

- (void)receivedAvailableVersions:(NSDictionary *)theVersions {
    self.versions = theVersions;
    NSLog(@"Got new versions");
    NSDictionary *deviceDetails = [self deviceDetails];
    NSString *deviceModel = [deviceDetails objectForKey:@"platform"];
    NSNumber *majorVersion = [NSNumber numberWithInteger:(NSInteger)0];
    NSNumber *minorVersion = [NSNumber numberWithInteger:(NSInteger)0];
    NSNumber *patchVersion = [NSNumber numberWithInteger:(NSInteger)0];
    NSString *productVersion;
    NSArray *versionComponents;
    NSEnumerator *versionEnumerator;
    id key;
    NSDictionary *modelVersions = [self.versions objectForKey:deviceModel];
    if (modelVersions != nil) {
        versionEnumerator = [modelVersions keyEnumerator];
        while (key = [versionEnumerator nextObject]) {
            if ([[modelVersions objectForKey:key] objectForKey:@"Restore"]) {
                productVersion = [[[modelVersions objectForKey:key] objectForKey:@"Restore"] objectForKey:@"ProductVersion"];
                versionComponents = [productVersion componentsSeparatedByString:@"."];
                if ([[versionComponents objectAtIndex:0] intValue] >=[majorVersion intValue]) {
                    majorVersion = [NSNumber numberWithInteger:[[versionComponents objectAtIndex:0] integerValue]];
                    if ([[versionComponents objectAtIndex:1] intValue] >= [minorVersion intValue]) {
                        minorVersion = [NSNumber numberWithInteger:[[versionComponents objectAtIndex:1] integerValue]];
                        if ([[versionComponents objectAtIndex:2] intValue] >= [patchVersion intValue]) {
                            patchVersion = [NSNumber numberWithInteger:[[versionComponents objectAtIndex:2] integerValue]];
                        }
                    }
                }
            }
        }
    }

    latestVersion.text = [NSString stringWithFormat:@"%@.%@.%@", majorVersion, minorVersion, patchVersion];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark TableView dataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [versions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"Dummy";
    
    return cell;
}

- (void)dealloc {
    [versions release];
    [super dealloc];
}

@end

