//
//  MessageCreationController.m
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import "MessageCreationController.h"
#import "FlakManager.h"
#import "FirstViewController.h"
#import "IPDCMessage.h"

@implementation MessageCreationController

@synthesize messageText;
@synthesize flakManager;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
*/

- (void) updateMessage {
	self.messageText.text = self.flakManager.currentMessage.messageText;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[self updateMessage];
}

- (void)viewWillAppear:(BOOL)animated { 
	[super viewWillAppear:animated]; 
	[self updateMessage];
}

- (IBAction)done {
	[self.navigationController popViewControllerAnimated:YES];
	NSLog(@"message text: %@", flakManager.currentMessage.messageText);
	[self.flakManager.firstViewController postMessage:self.flakManager.currentMessage.messageText];
	[self.flakManager.firstViewController retrieveNextMessages];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -
#pragma mark UITextFieldDelegate

// use this to do validation before the keyborard goes away.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder]; 
	return YES;
}

// used to update the user feedback( or outcome message ).
/*
- (void)textFieldDidEndEditing:(UITextField *)textField {
}
*/

#pragma mark -
#pragma mark UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
	if(textView == self.messageText) {
		self.flakManager.currentMessage.messageText = textView.text;
	}
	[textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text {
	if ([text isEqualToString:@"\n"]) {
		[textView resignFirstResponder];
		return NO;
	}
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[messageText dealloc];	
	[flakManager dealloc];
	[super dealloc];
}

@end
