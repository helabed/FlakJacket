//
//  FlakWhisperer.m
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import "FlakWhisperer.h"
#import "FlakManager.h"
#import "RootViewController.h"
#import "IPDCUser.h"
#import "IPDCMessage.h"
#import "UserPreferences.h"
#import "JSON.h"

@implementation FlakWhisperer

@synthesize preferences, flakManager;

- (void)initAndGetCookies{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];

    NSURL *url = [NSURL URLWithString:self.preferences.hostUrl];
    NSLog(@"cookies: %@", [cookieStorage cookiesForURL:url]);
    [pool drain];
}

- (void)createNewSessionForLogin{
    IPDCUser *user = [self.preferences getUser];

    NSString *jsonStringForSessionCreation = [user jsonStringForSessionCreation];
    NSLog(@"jsonStringForSessionCreation: %@", jsonStringForSessionCreation);
    NSString *urlString = [self.preferences.hostUrl stringByAppendingString:@"/session.json"];

    [FlakWhisperer postToFlak:urlString
				   jsonString: jsonStringForSessionCreation];
}

- (void)postMessage:(NSString *)messageBody {
	// the 2 statements below can be removed once we have a timer that maintains the session.
	[self initAndGetCookies];
	[self createNewSessionForLogin];

	IPDCUser *user = [self.preferences getUser];

	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSDictionary dictionaryWithObjectsAndKeys:
								 user.email, @"user_id",
								 messageBody, @"body",
								 nil],
                                @"message", nil];

    SBJSON *parser = [[SBJSON alloc] init];
    NSString *newJsonString = [parser stringWithObject:dictionary];
    [parser release];

    NSString *urlString = [self.preferences.hostUrl stringByAppendingString:@"/messages.json"];

    [FlakWhisperer postToFlak:urlString 
				   jsonString: newJsonString];
}

+(void) postToFlak: (NSString *)urlString jsonString: (NSString *)jsonStringToUse {
    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSData *data = [jsonStringToUse dataUsingEncoding:NSISOLatin2StringEncoding];
    [request setHTTPBody:data];
    NSURLResponse *response = nil;
    NSError *error = nil;

    NSData *responseData = [NSURLConnection 
                            sendSynchronousRequest:request 
                            returningResponse:&response 
                            error:&error];

    NSString *responseString = [[[NSString alloc] initWithData:responseData
                                                      encoding:NSUTF8StringEncoding] autorelease];

    NSLog(@"responseString: %@", responseString);
}

- (void)retrieveNextMessages {
    // the 2 statements below can be removed once we have a timer that maintains the session.
    [self initAndGetCookies];
    [self createNewSessionForLogin];

    NSNumber *maxMessageId = [self.flakManager.rootViewController getMaxMessageId];
    SBJSON *parser = [[SBJSON alloc] init];

    NSString *queryUrl = [self.preferences.hostUrl stringByAppendingString:@"/messages.json?kind=message&after_id=%@"];
    NSString *myUrl = [NSString stringWithFormat:queryUrl, maxMessageId];
    NSURL *url = [NSURL URLWithString:myUrl];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];

    NSArray *jsonArray = [parser objectWithString:jsonString];
    NSMutableArray *messages = [[NSMutableDictionary alloc] init];

    for (NSDictionary *messageDictionary in jsonArray) {
		// NSLog(@"=============Message Dictionary: %@======================", messageDictionary);
        IPDCMessage *message = [[IPDCMessage alloc] initWithJsonDictionary:messageDictionary];
		if(![message.messageText isEqual:[NSNull null]]) {
			[message logMessage];
			self.flakManager.currentMessage = message;
			[self.flakManager.rootViewController insertNewObject];
			[message release];
		}
    }

    NSLog(@"chat messages: %@", messages);
    [messages release];
    [parser release];
}

-(void) dealloc {
	[flakManager release];
	[preferences release];
	[super dealloc];
}

@end