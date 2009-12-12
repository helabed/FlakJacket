//
//  RootViewController.m
//  blankCoreData
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//

#import "RootViewController.h"
#import "FlakManager.h"
#import "IPDCMessage.h"
#import "MessageViewController.h"


@implementation RootViewController

@synthesize fetchedResultsController, managedObjectContext;
@synthesize flakManager;
@synthesize messageViewController;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	
	assert( flakManager != nil );
	assert( messageViewController != nil );
	
	// Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
																			   target:self 
																			   action:@selector(addMessageAction)];
																			   //action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
	
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. 
		 You should not use this function in a shipping application, although it 
		 may be useful during development. If it is not possible to recover from the error, 
		 display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

- (IBAction)addMessageAction { 
	NSLog(@"add message method invoked");
	
	self.flakManager.currentMessage.messageText = @"";
	//self.flakManager.currentMessage.kind = [selectedObject valueForKey:@"kind"];
	self.flakManager.currentMessage.lastName  = @"";
	self.flakManager.currentMessage.firstName  = @"";
	//self.flakManager.currentMessage.userId  = [selectedObject valueForKey:@"userId"];

	[self presentModalViewController:self.messageViewController animated:YES]; 
	
	NSLog(@"after call to Modal Dialog messageViewController");	
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Add a new object


- (void)insertNewObject {
	// Create a new instance of the entity managed by the fetched results controller.
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
	
	[newManagedObject setValue:self.flakManager.currentMessage.kind forKey:@"kind"];
	[newManagedObject setValue:self.flakManager.currentMessage.lastName forKey:@"lastName"];
	[newManagedObject setValue:self.flakManager.currentMessage.firstName forKey:@"firstName"];
	[newManagedObject setValue:self.flakManager.currentMessage.userId forKey:@"userId"];

	if([self.flakManager.currentMessage.messageText isEqual:[NSNull null]]) {
		NSLog(@"Clearing NSNull message text.");
		self.flakManager.currentMessage.messageText = @"";
	} else {
		NSLog(@"value: %@", self.flakManager.currentMessage.messageText);
	}

	[newManagedObject setValue:self.flakManager.currentMessage.messageText forKey:@"messageText"];
	[newManagedObject setValue:self.flakManager.currentMessage.messageId forKey:@"messageId"];
	[newManagedObject setValue:self.flakManager.currentMessage.dateTime forKey:@"dateTime"];
	
	// Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. 
		 You should not use this function in a shipping application, although it may be useful during development. 
		 If it is not possible to recover from the error, display an alert panel that instructs 
		 the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
	NSLog(@"newManagedObject: %@", newManagedObject);
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	cell.textLabel.text = [[managedObject valueForKey:@"messageText"] description];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here -- for example, create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	//MessageViewController *messageViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
	NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];

	NSLog(@"messageText %@", [selectedObject valueForKey:@"messageText"]);
	
	self.flakManager.currentMessage.messageText = [selectedObject valueForKey:@"messageText"];
	//self.flakManager.currentMessage.kind = [selectedObject valueForKey:@"kind"];
	self.flakManager.currentMessage.lastName  = [selectedObject valueForKey:@"lastName"];
	self.flakManager.currentMessage.firstName  = [selectedObject valueForKey:@"firstName"];
	//self.flakManager.currentMessage.userId  = [selectedObject valueForKey:@"userId"];

	
	NSLog(@"messageText from currentMessage %@", self.flakManager.currentMessage.messageText);
	
	[self.navigationController pushViewController:messageViewController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
											forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error = nil;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. 
			 You should not use this function in a shipping application, although it may be 
			 useful during development. If it is not possible to recover from the error, 
			 display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Fetched results controller

- (NSNumber *)getMaxMessageId {
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];

	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:context];
	[request setEntity:entity];

	// Specify that the request should return dictionaries.
	[request setResultType:NSDictionaryResultType];

	// Create an expression for the key path.
	NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"messageId"];

	// Create an expression to represent the minimum value at the key path 'creationDate'
	NSExpression *maxExpression = [NSExpression expressionForFunction:@"max:" arguments:[NSArray arrayWithObject:keyPathExpression]];

	// Create an expression description using the minExpression and returning a date.
	NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];

	// The name is the key that will be used in the dictionary for the return value.
	[expressionDescription setName:@"maxMessageId"];
	[expressionDescription setExpression:maxExpression];
	[expressionDescription setExpressionResultType:NSInteger16AttributeType];

	// Set the request's properties to fetch just the property represented by the expressions.
	[request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];

	// Execute the fetch.
	NSError *error;
	NSNumber *maxValueReturned;
	NSArray *objects = [managedObjectContext executeFetchRequest:request error:&error];
	if (objects == nil) {
		// Handle the error.
		NSLog(@"We got nil objects after the executeFetchRequest");
	}
	else {
		if ([objects count] > 0) {
			maxValueReturned = [[objects objectAtIndex:0] valueForKey:@"maxMessageId"];
			//NSLog(@"Maximumu messageId: %@", [[objects objectAtIndex:0] valueForKey:@"maxMessageId"]);
			NSLog(@"Maximumu messageId: %@", maxValueReturned);
		}
	}
	[expressionDescription release];
	[request release];

	return maxValueReturned;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
	*/
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"messageId" ascending:NO];
	//NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateTime" ascending:NO];
	//NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"messageText" ascending:NO];
	
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
																								managedObjectContext:managedObjectContext 
																								  sectionNameKeyPath:nil 
																										   cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
}    


// NSFetchedResultsControllerDelegate method to notify the delegate that all section and object changes have been processed. 
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// In the simplest, most efficient, case, reload the table view.
	[self.tableView reloadData];
}

/*
 Instead of using controllerDidChangeContent: to respond to all changes, you can implement all the delegate methods 
 to update the table view in response to individual changes.  This may have performance implications if 
 a large number of changes are made simultaneously.

// Notifies the delegate that section and object changes are about to be processed and notifications will be sent. 
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo 
 atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	// Update the table view appropriately.
}

- (void)controller:(NSFetchedResultsController *)controller 
 didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath 
 forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	// Update the table view appropriately.
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
} 
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	// Relinquish ownership of any cached data, images, etc that aren't in use.
}


- (void)dealloc {
	[flakManager release];
	[messageViewController release];
	
	[fetchedResultsController release];
	[managedObjectContext release];
    [super dealloc];
}


@end

