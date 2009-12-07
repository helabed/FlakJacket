//
//  UserPreferencesViewController.m
//  blankCoreData
//
//  Created by Stephen Anderson on 12/6/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import "UserPreferencesViewController.h"
#import "UserPreferences.h"

@implementation UserPreferencesViewController

@synthesize preferences, firstNameTextField, lastNameTextField, emailAddressTextField, passwordTextField;

#pragma mark -
#pragma mark UITextFieldDelegate

// use this to do validation before the keyborard goes away.
- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
	NSLog(@"textFieldShouldReturn method invoked");
	[textField resignFirstResponder]; 
	return YES;
}

// used to update the user feedback( or outcome message ).
- (void)textFieldDidEndEditing:(UITextField *)textField { 
	NSLog(@"textFieldDidEndEditing method invoked: %@", textField.text);

	if (textField == self.firstNameTextField) {
		self.preferences.firstName = textField.text;
	} else if (textField == self.lastNameTextField) {
		self.preferences.lastName = textField.text;
	} else if(textField == self.emailAddressTextField) {
		self.preferences.emailAddress = textField.text;
	} else if(textField == self.passwordTextField){
		self.preferences.password = textField.text;
	}
	[self.preferences saveUserDefaultsToPlist];
}

#pragma mark -
#pragma mark UIViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	assert(preferences != nil);
	self.emailAddressTextField.text = preferences.emailAddress;
	self.passwordTextField.text = preferences.password;
	self.firstNameTextField.text = preferences.firstName;
	self.lastNameTextField.text = preferences.lastName;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [super dealloc];
}

@end
