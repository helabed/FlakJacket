//
//  UserPreferences.h
//  blankCoreData
//
//  Created by Stephen Anderson on 12/6/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserPreferences : NSObject {
	NSString *emailAddress;
	NSString *password;
}

@property(nonatomic, retain) NSString *emailAddress;
@property(nonatomic, retain) NSString *password;

@end
