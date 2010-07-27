//
//  AvailableVersions.h
//  Phobos
//
//  Created by Wes Morgan on 7/26/10.
//  Copyright (c) 2010 Democratic National Committee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AvailableVersionsDelegate <NSObject>

- (void)receivedAvailableVersions:(NSDictionary *)theAvailableVersions;

@end
    

@interface AvailableVersions : NSObject {
    id _delegate;
    NSDictionary *versions;
}

@property (nonatomic, retain, readonly) NSDictionary *versions;

- (void)loadAvailableVersionsWithDelegate:(id)aDelegate;

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@end
