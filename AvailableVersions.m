//
//  AvailableVersions.m
//  Phobos
//
//  Created by Wes Morgan on 7/26/10.
//  Copyright (c) 2010 Democratic National Committee. All rights reserved.
//

#import "AvailableVersions.h"


@implementation AvailableVersions

@synthesize versions;

- (void)loadAvailableVersionsWithDelegate:(id)aDelegate {
    [self setDelegate:aDelegate];
    
    NSURL *phobosURL = [NSURL URLWithString:@"http://phobos.apple.com/version"];
    
    versions = [[[[[NSDictionary alloc] initWithContentsOfURL:phobosURL] objectForKey:@"MobileDeviceSoftwareVersionsByVersion"] objectForKey:@"6"] objectForKey:@"MobileDeviceSoftwareVersions"];
    
    if ([_delegate respondsToSelector:@selector(receivedAvailableVersions:)]) {
        [_delegate receivedAvailableVersions:versions];
    } else {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Delegate doesn't respond to receivedAvailableVersions:"];
    }
}

#pragma mark -
#pragma mark Delegate methods

- (id)delegate {
    return _delegate;
}

- (void)setDelegate:(id)new_delegate {
    _delegate = new_delegate;
}

- (void)dealloc {
    [versions release];
    [super dealloc];
}

@end
