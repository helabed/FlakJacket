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
        dictionaryFromDefaultPlist = [NSMutableDictionary
									  dictionaryWithContentsOfFile:settingsPlistPath];
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:[dictionaryFromDefaultPlist objectForKey:@"currentHostURL"]
                 forKey:@"currentHostURL"];

//    [defaults setObject:[dictionaryFromDefaultPlist objectForKey:@"savedHosts"]
//                 forKey:@"savedHosts"];

    [defaults setObject:[dictionaryFromDefaultPlist objectForKey:@"loginData"]
                 forKey:@"loginData"];
}

- (void)saveUserDefaultsToPlist {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *loginData = [userDefaults objectForKey:@"loginData"];
	[loginData setObject:self.firstName forKey:@"firstName"];
	[loginData setObject:self.lastName forKey:@"lastName"];
	[loginData setObject:self.emailAddress forKey:@"emailAddress"];
	[loginData setObject:self.password forKey:@"password"];
	[userDefaults setObject:loginData
					 forKey:@"loginData"];
	
	//NSString *settingsPlistPath = [[NSBundle mainBundle]
    //                               pathForResource:@"FlakSettings" ofType:@"plist"];
	
	//[userDefaults writeToFile:settingsPlistPath atomically: YES];
	//[userDefaults registerDefaults:userDefaults];
	[userDefaults synchronize];

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
