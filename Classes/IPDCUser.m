//
//  IPDCUser.m
//  json_tests
//
//  Created by Eric Knapp on 10/28/09.
//  Copyright 2009 Madison Area Technical College. All rights reserved.
//

#import "IPDCUser.h"
#import "JSON.h"

@implementation IPDCUser

@synthesize userId;
@synthesize password;
@synthesize firstName;
@synthesize timeStamp;
@synthesize email;
@synthesize createdAt;
@synthesize lastActivityAt;
@synthesize lastName;

- (id)initWithJsonGeneralUser:(NSMutableDictionary *)userDictionary {
    
    NSDictionary *user = [userDictionary objectForKey:@"user"];
    
    if (self = [super init]) {
        self.userId = [user objectForKey:@"id"];
        self.email = [user objectForKey:@"email"];
        self.firstName = [user objectForKey:@"first_name"];
        self.lastName = [user objectForKey:@"last_name"];
    }
    
    return self;
}

- (NSDictionary *)userAsDictionary {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.firstName, @"first_name",
                                 self.lastName, @"last_name",
                                 self.email, @"email",
                                 self.password, @"password", 
                                 self.password, @"password_confirmation",
                                 nil],
                                @"user", nil];
    
    
    return dictionary;
    
}

- (NSString *)jsonStringForUserCreation {
    
    SBJSON *parser = [[SBJSON alloc] init];

    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flak4president", @"key",
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.firstName, @"first_name",
                                 self.lastName, @"last_name",
                                 self.email, @"email",
                                 self.password, @"password", 
                                 self.password, @"password_confirmation",
                                 nil],
                                @"user", nil];
    
    
    NSString *newJsonString = [parser stringWithObject:user];
    
    
    return newJsonString;
}

- (NSString *)jsonStringForSessionCreation {
    SBJSON *parser = [[SBJSON alloc] init];
    
    NSDictionary *session = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           self.email, @"email",
                           self.password, @"password", 
                           nil],
                          @"session", nil];
    
    
    NSString *newJsonString = [parser stringWithObject:session];
    
    
    return newJsonString;
    
}

@end





