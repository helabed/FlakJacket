//
//  RootViewController.h
//  blankCoreData
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
