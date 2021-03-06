//
//  MessageViewController.h
//  blankCoreData
//
//  Created by Hani Elabed on 11/30/09.
//  Copyright 2009 Elabed Enterprises, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlakManager;

@interface MessageViewController : UIViewController {
	UITextView *messageText;
	UITextField *firstName;
	UITextField *lastName;
	FlakManager *flakManager;
}

@property (nonatomic, retain) IBOutlet UITextView *messageText;
@property (nonatomic, retain) IBOutlet UITextField *firstName;
@property (nonatomic, retain) IBOutlet UITextField *lastName;
@property (nonatomic, retain) IBOutlet 	FlakManager *flakManager;

- (IBAction)done; 

@end
