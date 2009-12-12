//
//  UserPreferencesViewController.h
//  blankCoreData
//
//  Created by Stephen Anderson on 12/6/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserPreferences;

@interface UserPreferencesViewController : UIViewController <UITextFieldDelegate> {
	UserPreferences *preferences;
	UITextField *firstNameTextField;
	UITextField *lastNameTextField;
	UITextField *emailAddressTextField;
	UITextField *passwordTextField;
	UITextField *hostUrlTextField;
}

@property(nonatomic, retain) IBOutlet UserPreferences *preferences;
@property(nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property(nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property(nonatomic, retain) IBOutlet UITextField *emailAddressTextField;
@property(nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property(nonatomic, retain) IBOutlet UITextField *hostUrlTextField;

@end
