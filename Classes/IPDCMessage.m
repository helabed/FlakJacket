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

- (id)initWithJsonDictionary:(NSDictionary *)message {
    if (self = [super init]) {
        NSDictionary *messageDictionary = [message objectForKey:@"message"];
        self.messageId   = [messageDictionary objectForKey:@"id"];
        self.kind = [messageDictionary objectForKey:@"kind"];
        self.dateTime = [NSDate dateWithNaturalLanguageString:[messageDictionary objectForKey:@"created_at"]];
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
        self.dateTime = [NSDate dateWithNaturalLanguageString:[messageArray objectAtIndex:1]];
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