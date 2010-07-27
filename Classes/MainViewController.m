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

@synthesize versions;

- (void)viewDidLoad {
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

- (void)receivedAvailableVersions:(NSDictionary *)theVersions {
    versions = theVersions;
    NSLog(@"Got new versions");
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

