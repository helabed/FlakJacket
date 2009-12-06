//
//  RootViewController.h
//  blankCoreData
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//
@class FlakManager;
@class MessageViewController;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
	FlakManager *flakManager;
	MessageViewController *messageViewController;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet 	FlakManager *flakManager;
@property (nonatomic, retain) IBOutlet  MessageViewController *messageViewController;


- (void)insertNewObject;
- (NSNumber *)getMaxMessageId;

@end
