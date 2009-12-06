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
}

@property(nonatomic, retain) IBOutlet UserPreferences *preferences;

@end
