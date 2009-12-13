//
//  FlakManager.m
//  blankCoreData
//
//  Created by Hani Elabed on 11/29/09.
//  Copyright 2009 Elabed Enterprises, LLC. All rights reserved.
//

#import "FlakManager.h"
#import "IPDCUser.h"
#import "IPDCMessage.h"


@implementation FlakManager

@synthesize firstViewController;
@synthesize rootViewController;
@synthesize coreDataAppDelegate;

@synthesize currentUser;
@synthesize currentMessage;
@synthesize currentListOfMessages;


- (void)dealloc {
	[currentUser release];
	[currentMessage release];
	[currentListOfMessages release];
	[firstViewController release];
	[rootViewController release];
	[coreDataAppDelegate release];

    [super dealloc];
}

@end