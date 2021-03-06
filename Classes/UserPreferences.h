//
//  UserPreferences.h
//  blankCoreData
//
//  Created by Stephen Anderson on 12/6/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IPDCUser;

@interface UserPreferences : NSObject {
	NSString *firstName;
	NSString *lastName;
	NSString *emailAddress;
	NSString *password;
	NSString *hostUrl;
}

@property(nonatomic, retain) NSString *firstName;
@property(nonatomic, retain) NSString *lastName;
@property(nonatomic, retain) NSString *emailAddress;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, retain) NSString *hostUrl;

- (void)saveUserDefaultsToPlist;
- (IPDCUser *)getUser;

@end
