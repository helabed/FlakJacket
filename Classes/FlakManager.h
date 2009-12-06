//
//  FlakManager.h
//  blankCoreData
//
//  Created by Hani Elabed on 11/29/09.
//  Copyright 2009 Elabed Enterprises, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FirstViewController;
@class RootViewController;
@class blankCoreDataAppDelegate;
@class IPDCUser;
@class IPDCMessage;

@interface FlakManager : NSObject {
	FirstViewController *firstViewController;
	RootViewController  *rootViewController;
	blankCoreDataAppDelegate *coreDataAppDelegate;

	IPDCUser			*currentUser;
	IPDCMessage			*currentMessage;
	NSArray				*currentListOfMessages;
}


@property (nonatomic, retain) IBOutlet FirstViewController *firstViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet blankCoreDataAppDelegate *coreDataAppDelegate;

@property (nonatomic, retain) IBOutlet IPDCUser    *currentUser;
@property (nonatomic, retain) IBOutlet IPDCMessage *currentMessage;
@property (nonatomic, retain) IBOutlet NSArray     *currentListOfMessages;

@end
