//
//  RootViewController.h
//  blankCoreData
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//
@class FlakManager;
@class FlakWhisperer;
@class MessageViewController;
@class MessageCreationController;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
	FlakManager *flakManager;
	FlakWhisperer *whisperer;
	MessageViewController *messageViewController;
	MessageCreationController *messageCreationController;
	UITableViewCell *nibLoadedCell;
	UIView *headerView;
	UITableView *tableView;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet 	FlakManager *flakManager;
@property (nonatomic, retain) IBOutlet	FlakWhisperer *whisperer;
@property (nonatomic, retain) IBOutlet  MessageViewController *messageViewController;
@property (nonatomic, retain) IBOutlet  MessageCreationController *messageCreationController;
@property (nonatomic, retain) IBOutlet	UITableViewCell *nibLoadedCell;
@property (nonatomic, retain) IBOutlet	UIView *headerView;
@property (nonatomic, retain) IBOutlet  UITableView *tableView;

- (void)insertNewObject;
- (NSNumber *)getMaxMessageId;
- (IBAction)getNewestMessages;

@end