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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.messageText.text = self.flakManager.currentMessage.messageText;
	//self.userId.text = self.flakManager.currentMessage.userId;
	self.firstName.text = self.flakManager.currentMessage.firstName;
	self.lastName.text = self.flakManager.currentMessage.lastName;
	
}

- (void)viewWillAppear:(BOOL)animated { 
	[super viewWillAppear:animated]; 

	self.messageText.text = self.flakManager.currentMessage.messageText;
	//self.userId.text = self.flakManager.currentMessage.userId;
	self.firstName.text = self.flakManager.currentMessage.firstName;
	self.lastName.text = self.flakManager.currentMessage.lastName;
	
}

- (IBAction)done { 
	//[[self parentViewController] dismissModalViewControllerAnimated:YES]; 
	
	[self.navigationController popViewControllerAnimated:YES];
} 


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


// use this to do validation before the keyborard goes away.
- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
	[textField resignFirstResponder]; 
	return YES;
}

// used to update the user feedback( or outcome message ).
- (void)textFieldDidEndEditing:(UITextField *)textField { 
	if(textField == self.messageText) {
 		//[self.wordsModel.words addObject:self.newWord.text];
		//[self.wordsModel saveData];
		
		self.messageText.text =  @"";	
		[self dismissModalViewControllerAnimated:YES];
	}
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
