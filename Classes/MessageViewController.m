//
//  MessageViewController.m
//  blankCoreData
//
//  Created by Hani Elabed on 11/30/09.
//  Copyright 2009 Elabed Enterprises, LLC. All rights reserved.
//

#import "MessageViewController.h"
#import "FlakManager.h"
#import "IPDCMessage.h"
#import "FirstViewController.h"

@implementation MessageViewController

@synthesize messageText;
@synthesize userId;
@synthesize firstName;
@synthesize lastName;

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
	//self.userId.text = self.flakManager.currentMessage.userId;
	self.firstName.text = self.flakManager.currentMessage.firstName;
	self.lastName.text = self.flakManager.currentMessage.lastName;

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self updateMessage];

	
}

- (void)viewWillAppear:(BOOL)animated { 
	[super viewWillAppear:animated]; 

	[self updateMessage];
//	self.messageText.text = self.flakManager.currentMessage.messageText;
//	//self.userId.text = self.flakManager.currentMessage.userId;
//	self.firstName.text = self.flakManager.currentMessage.firstName;
//	self.lastName.text = self.flakManager.currentMessage.lastName;
	
}

- (IBAction)done { 
	//[[self parentViewController] dismissModalViewControllerAnimated:YES]; 
	
	NSLog(@"done method invoked");
	
	[self.navigationController popViewControllerAnimated:YES];

	if( [self parentViewController] != nil ) {
		[self.flakManager.firstViewController postMessage:self.flakManager.currentMessage.messageText];
		[[self parentViewController] dismissModalViewControllerAnimated:YES];
	}
} 


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


// use this to do validation before the keyborard goes away.
- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
	NSLog(@"textFieldShouldReturn method invoked");
	[textField resignFirstResponder]; 
	return YES;
}

// used to update the user feedback( or outcome message ).
- (void)textFieldDidEndEditing:(UITextField *)textField { 
	NSLog(@"textFieldDidEndEditing method invoked");
	if(textField == self.firstName) {
 		//[self.wordsModel.words addObject:self.newWord.text];
		//[self.wordsModel saveData];		
		self.firstName =  textField;	
	}
	else if( textField == self.lastName ){
		self.lastName = textField;
	}
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	NSLog(@"textViewDidEndEditing method invoked");
	if(textView == self.messageText) {
 		//[self.wordsModel.words addObject:self.newWord.text];
		//[self.wordsModel saveData];
		self.flakManager.currentMessage.messageText = textView.text;
		//[self dismissModalViewControllerAnimated:YES];
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
	[userId dealloc];
	[firstName dealloc];
	[lastName dealloc];
	
	[flakManager dealloc];
    
	[super dealloc];
}

@end
