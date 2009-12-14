//
//  Chat.m
//  json_tests
//
//  Created by Eric Knapp on 10/23/09.
//  Copyright 2009 Madison Area Technical College. All rights reserved.
//

#import "IPDCMessage.h"
#import "JSON.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@implementation IPDCMessage

@synthesize messageId;
@synthesize kind;
@synthesize dateTime;
@synthesize userId;
@synthesize messageText;
@synthesize firstName;
@synthesize lastName;

-(void) logMessage {
	NSLog(@"=======================================");
	NSLog(@"messageId: %@", messageId);
	NSLog(@"kind: %@", kind);
	NSLog(@"dateTime: %@", dateTime);
	NSLog(@"userId: %@", userId);
	NSLog(@"messageText: %@", messageText);
	NSLog(@"firstName: %@", firstName);
	NSLog(@"lastName: %@", lastName);
	NSLog(@"=======================================");
}

- (NSDate *) createLocalDate:(NSDictionary *)messageDictionary forKey:(NSString *)key {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];

	// dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
	dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'-06:00'";

    // The create date of the message returned by the Flak server
	NSString *dateString = [messageDictionary objectForKey:key];
	NSLog(@"/////C: dateString: %@", dateString);
	
    NSDate *sourceDate = [dateFormatter dateFromString:dateString];
	NSLog(@"/////D: sourceDate: %@", sourceDate);

    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];

    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;

    NSDate *destinationDate = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] autorelease];
	[dateFormatter release];
    return destinationDate;
}

- (id)initWithJsonDictionary:(NSDictionary *)message {
    if (self = [super init]) {
        NSDictionary *messageDictionary = [message objectForKey:@"message"];
        self.messageId   = [messageDictionary objectForKey:@"id"];
        self.kind = [messageDictionary objectForKey:@"kind"];
        // self.dateTime = [NSDate dateWithNaturalLanguageString:[messageDictionary objectForKey:@"created_at"]];

        self.dateTime = [self createLocalDate:messageDictionary forKey:@"created_at"];
		NSLog(@"<<<<<<<<<dateTime b: %@", self.dateTime);

        self.userId   = [messageDictionary objectForKey:@"user_id"];
        self.messageText = [messageDictionary objectForKey:@"body"];
        self.firstName = [messageDictionary objectForKey:@"user_first_name"];
        self.lastName = [messageDictionary objectForKey:@"user_last_name"];
    }

    return self;
}


- (id)initWithJsonArray:(NSMutableArray *)messageArray {
    if (self = [super init]) {
        self.messageId   = [messageArray objectAtIndex:0];
        //self.dateTime = [NSDate dateWithNaturalLanguageString:[messageArray objectAtIndex:1]];
        self.dateTime = [self createLocalDate:([messageArray objectAtIndex:1]) forKey:@"created_at"];
        self.userId   = [messageArray objectAtIndex:2];
        self.messageText = [messageArray objectAtIndex:3];
    }
    
    return self;
}

- (BOOL)isChatMessage {
    if ([self.kind isEqualToString:@"message"]) {
        return YES;
    } else {
        return NO;
    }

}

- (NSDictionary *)messageDictionary {
    
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                [NSString stringWithFormat:@"%@", self.messageId], @"message_id",
//                                [NSString stringWithFormat:@"%@", self.dateTime], @"datetime",
//                                [NSString stringWithFormat:@"%@", self.userId], @"user_id",
//                                self.messageText, @"message_text", nil];


    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.userId, @"user_id", 
                                    self.messageText, @"body", 
                                    nil],
                                @"message", nil];
    
    
    return dictionary;
    
}

- (NSString *)jsonStringFromObject {

    SBJSON *parser = [[SBJSON alloc] init];
    
    NSString *newJsonString = [parser stringWithObject:[self messageDictionary]];
    
    //NSString *finalJsonString = [NSString stringWithFormat:@"{ \"message\": %@ }", newJsonString];
    
    [parser release];
    
    NSLog(@"newJsonString: %@", newJsonString);
    
    return newJsonString;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Message: messageId=%@, kind=%@, datetime=%@, userId=%@, messageText:%@, firstName=%@, lastName=%@",
            self.messageId, self.kind, self.dateTime, self.userId, self.messageText, self.firstName, self.lastName];
}

- (NSString *)jsonStringForMessageCreation {
    SBJSON *parser = [[SBJSON alloc] init];
    
    NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              self.messageText, @"body",
                              nil],
                             @"message", nil];
    
    
    NSString *newJsonString = [parser stringWithObject:message];
    
    
    return newJsonString;
    
}

- (NSString *)jsonStringForMessageCreationTouch {
    
    
    NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              self.messageText, @"body",
                              nil],
                             @"message", nil];
    
    
//    NSString *newJsonString = [parser stringWithObject:message];
    NSString *newJsonString = [[CJSONSerializer serializer] serializeObject:message];
    
    NSLog(@"newJsonString with Touch: %@", newJsonString);
    return newJsonString;
    
}


- (void)dealloc {
    self.messageId = nil;
    self.kind = nil;
    self.dateTime = nil;
    self.userId = nil;
    self.messageText = nil;
    self.firstName = nil;
    self.lastName = nil;

    
    [super dealloc];
}



@end
