//
//  MessageCreationController.h
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlakManager;
@class FlakWhisperer;

@interface MessageCreationController : UIViewController  <UITextFieldDelegate,UITextViewDelegate> {
	UITextView *messageText;
	FlakManager *flakManager;
	FlakWhisperer *whisperer;
}

@property (nonatomic, retain) IBOutlet UITextView *messageText;
@property (nonatomic, retain) IBOutlet 	FlakManager *flakManager;
@property (nonatomic, retain) IBOutlet FlakWhisperer *whisperer;

- (IBAction)done;

@end
