//
//  UserPreferences.m
//  blankCoreData
//
//  Created by Stephen Anderson on 12/6/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import "UserPreferences.h"

@implementation UserPreferences

@synthesize firstName, lastName, emailAddress, password;


- (void)createUserDefaultsFromPlist {
    NSString *settingsPlistPath = [[NSBundle mainBundle]
                                   pathForResource:@"FlakSettings" ofType:@"plist"];

    NSDictionary *dictionaryFromDefaultPlist;

    if (settingsPlistPath) {
        dictionaryFromDefaultPlist = [NSMutableDictionary dictionaryWithContentsOfFile:settingsPlistPath];
    }

	NSLog(@"dictionaryFromDefaultPlist: %@", dictionaryFromDefaultPlist);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	NSLog(@"defaults before addition: %@", [defaults dictionaryRepresentation]);

    [defaults setObject:[dictionaryFromDefaultPlist objectForKey:@"currentHostURL"]
                 forKey:@"currentHostURL"];

    [defaults setObject:[dictionaryFromDefaultPlist objectForKey:@"loginData"]
                 forKey:@"loginData"];

	NSLog(@"defaults after addition: %@", [defaults dictionaryRepresentation]);
}

- (void)saveUserDefaultsToPlist {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

	NSLog(@"defaults before saving: %@", [userDefaults dictionaryRepresentation]);

	// load the old data
	NSDictionary *oldLoginData =  [userDefaults objectForKey:@"loginData"];

	NSLog(@"oldLoginData: %@", oldLoginData);

	NSLog(@"about to create loginData with: dictionaryWithObjectsAndKeys");
	// create a new Dictionary to save
	NSDictionary *loginData = [NSDictionary dictionaryWithObjectsAndKeys:self.firstName, @"firstName",
	                                                                     self.lastName, @"lastName",
	                                                                     self.emailAddress, @"emailAddress",
	                                                                     self.password, @"password",
	                                                                     nil];

	NSLog(@"New Login Data: %@", loginData);

	NSLog(@"about to change the content of loginData");

	// Replace the old date in NSUserdefaults
	[[NSUserDefaults standardUserDefaults] setObject:loginData forKey:@"loginData"];

	// check to make sure it looks like it should by visual inspection by a human !!
	NSLog(@"defaults after saving: %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
}


- (id)init {
	NSLog(@"in init method");

    if (self = [super init]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *currentHostURL = [userDefaults stringForKey:@"currentHostURL"];

        // Load bundle plist if settings file doesn't exist
        if (currentHostURL == nil) {
            NSLog(@"User defaults not found so setting them from plist");
            [self createUserDefaultsFromPlist];
        } else {
            NSLog(@"User defaults set so nothing to do");
        }

		NSDictionary *loginData = [userDefaults objectForKey:@"loginData"];
		self.firstName = [loginData objectForKey:@"firstName"];
		self.lastName = [loginData objectForKey:@"lastName"];
		self.emailAddress = [loginData objectForKey:@"emailAddress"];
		self.password = [loginData objectForKey:@"password"];
		NSLog(@"set emailAddress to: %@", self.emailAddress);
    }
    return self;
}

@end
