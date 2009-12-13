//
//  IPDCMessage.h
//  json_tests
//  
//  This is the iPhone Dev Chat Message class
//
//  Created by Eric Knapp on 10/23/09.
//  Copyright 2009 Madison Area Technical College. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SBJSON;

@interface IPDCMessage : NSObject {
    NSNumber    *messageId;
    NSString    *kind;
    NSDate      *dateTime;
    NSNumber    *userId;
    NSString    *firstName;
    NSString    *lastName;  
    NSString    *messageText;
    NSDateFormatter* dateFormatter;
}

@property (nonatomic, retain) NSNumber  *messageId;
@property (nonatomic, retain) NSString *kind;
@property (nonatomic, retain) NSDate    *dateTime;
@property (nonatomic, retain) NSNumber  *userId;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString  *messageText;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;


- (id)initWithJsonDictionary:(NSDictionary *)messageDictionary;
- (id)initWithJsonArray:(NSMutableArray *)messageArray;
- (NSString *)jsonStringFromObject;
- (NSString *)jsonStringForMessageCreation;
- (NSDictionary *)messageDictionary;
- (BOOL)isChatMessage;
- (void)logMessage;

@end
