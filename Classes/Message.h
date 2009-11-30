//
//  Message.h
//  blankCoreData
//
//  Created by Hani Elabed on 11/29/09.
//  Copyright 2009 Elabed Enterprises, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Message :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSDate * dateTime;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSNumber * messageId;
@property (nonatomic, retain) NSString * messageText;

@end



