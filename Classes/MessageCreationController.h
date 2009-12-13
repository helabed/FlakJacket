//
//  MessageCreationController.h
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlakManager;

@interface MessageCreationController : UITableViewController {
	UITextView    *messageText;
	UITextField    *userId;
	UITextField    *firstName;
	UITextField    *lastName;
	FlakManager    *flakManager;
}

@property (nonatomic, retain) IBOutlet UITextView    *messageText;
@property (nonatomic, retain) IBOutlet UITextField    *userId;
@property (nonatomic, retain) IBOutlet UITextField    *firstName;
@property (nonatomic, retain) IBOutlet UITextField    *lastName;

@property (nonatomic, retain) IBOutlet 	FlakManager *flakManager;

- (IBAction)done;

@end
