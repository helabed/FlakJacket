//
//  User.h
//  blankCoreData
//
//  Created by Hani Elabed on 11/29/09.
//  Copyright 2009 Elabed Enterprises, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface User :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSDate * lastActivityAt;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * lastName;

@end



