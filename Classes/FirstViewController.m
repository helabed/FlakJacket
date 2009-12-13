//
//  FirstViewController.m
//  blankTabBarNav
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//

#import "FirstViewController.h"
#import "JSON.h"
#import "FlakWhisperer.h"
#import "IPDCMessage.h"
#import "IPDCUser.h"
#import "FlakManager.h"
#import "RootViewController.h"
#import "UserPreferences.h"

@implementation FirstViewController

@synthesize flakManager, preferences, whisperer;

- (IBAction)testFlak{
	[self testForFlakServer:self.preferences.hostUrl];
}

- (IBAction)testCreateNewAccount{
	[self.whisperer initAndGetCookies];
	[self createNewAccount];
}

- (IBAction)testLogin{
	[self.whisperer initAndGetCookies];
	[self.whisperer createNewSessionForLogin];
}

- (IBAction)testGettingMessages{
	[self.whisperer initAndGetCookies];
	[self retrieveNextMessages];
}

- (IBAction)testPostHelloFromUser{
	[self.whisperer initAndGetCookies];
	[self postAHelloFromUser];
}

- (void)postAHelloFromUser{
	IPDCUser *user = [self.preferences getUser];
	NSString *message = [NSString stringWithFormat:@"Hello from %@ %@", user.firstName, user.lastName];
	[self.whisperer postMessage:message];
}

- (void)createNewAccount{
    IPDCUser *user = [self.preferences getUser];
    NSString *jsonStringForUser = [user jsonStringForUserCreation];
    NSLog(@"createNewAccount: %@", jsonStringForUser);
    NSString *urlString = [self.preferences.hostUrl stringByAppendingString:@"/users.json"];

    [FlakWhisperer postToFlak:urlString 
		  jsonString:jsonStringForUser];
}

- (void)retrieveNextMessages {
    // the 2 statements below can be removed once we have a timer that maintains the session.
    [self.whisperer initAndGetCookies];
    [self.whisperer createNewSessionForLogin];

    NSNumber *maxMessageId = [self.flakManager.rootViewController getMaxMessageId];
    NSLog(@"we have retrieved the maxMessageId: %@", maxMessageId);

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

- (void)testForFlakServer:(NSString *)hostURL {
    NSString *urlString = [NSString stringWithFormat:@"%@/flak", hostURL];
    NSLog(@"urlString: %@", urlString);

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSHTTPURLResponse *response = nil;
    NSError *error = nil;

    [NSURLConnection sendSynchronousRequest:request 
                          returningResponse:&response 
                                      error:&error];

    NSInteger statusCode = [response statusCode];
    NSLog(@"statusCode: %d", statusCode);
}

- (void)viewDidLoad {
    [super viewDidLoad];
	assert(flakManager != nil);
	assert(preferences != nil);
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[flakManager release];
	[whisperer release];
    [super dealloc];
}

@end