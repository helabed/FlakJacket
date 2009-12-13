//
//  FlakWhisperer.m
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import "FlakWhisperer.h"
#import "IPDCUser.h"
#import "UserPreferences.h"
#import "JSON.h"

@implementation FlakWhisperer

@synthesize preferences;

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

@end