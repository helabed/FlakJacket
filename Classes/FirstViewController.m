//
//  FirstViewController.m
//  blankTabBarNav
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//

#import "FirstViewController.h"
#import "JSON.h"
#import "IPDCMessage.h"
#import "IPDCUser.h"
#import "FlakManager.h"
#import "RootViewController.h"
#import "UserPreferences.h"

@implementation FirstViewController

@synthesize flakManager, preferences;

- (IBAction)testFlak{
	[self testForFlakServer:@"http://flak.heroku.com"];
}

- (IBAction)testCreateNewAccount{
	[self initAndGetCookies];
	[self createNewAccount];
}

- (IBAction)testLogin{
	[self initAndGetCookies];
	[self createNewSessionForLogin];
}
- (IBAction)testGettingMessages{
	[self initAndGetCookies];
	[self retrieveNextMessages];
}

- (IBAction)testPostHelloFromUser{
	[self initAndGetCookies];
	[self postAHelloFromUser];
}

- (IPDCUser *) getUser{
    IPDCUser *user = [[IPDCUser alloc] init];
	user.firstName = self.preferences.firstName;
	user.lastName = self.preferences.lastName;
    user.email = self.preferences.emailAddress;
    user.password = self.preferences.password;
	return user;
}

- (void)createNewSessionForLogin{
    IPDCUser *user = [self getUser];
	
    NSString *jsonStringForSessionCreation = [user jsonStringForSessionCreation];
    NSLog(@"jsonStringForSessionCreation: %@", jsonStringForSessionCreation);
    NSString *urlString = @"http://flak.heroku.com/session.json";
	
    [self postToFlak:urlString 
		  jsonString: jsonStringForSessionCreation];
}

- (void)postMessage:(NSString *)messageBody {
	// the 2 statements below can be removed once we have a timer that maintains the session.
	[self initAndGetCookies];
	[self createNewSessionForLogin];

	IPDCUser *user = [self getUser];

	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSDictionary dictionaryWithObjectsAndKeys:
								 user.email, @"user_id",
								 messageBody, @"body", 
								 nil],
                                @"message", nil];

    SBJSON *parser = [[SBJSON alloc] init];
    NSString *newJsonString = [parser stringWithObject:dictionary];

    // NSString *finalJsonString = [NSString stringWithFormat:@"{ \"message\": %@ }", newJsonString];

    [parser release];
    NSLog(@"newJsonString: %@", newJsonString);

	// NSString *jsonStringForSessionCreation = [user jsonStringForSessionCreation];
    // NSLog(@"jsonStringForSessionCreation: %@", jsonStringForSessionCreation);

    NSString *urlString = @"http://flak.heroku.com/messages.json";

    [self postToFlak:urlString 
		  jsonString: newJsonString];
}


- (void)postAHelloFromUser{
	IPDCUser *user = [self getUser];
	NSString *message = [NSString stringWithFormat:@"Hello from %@ %@", user.firstName, user.lastName];
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSDictionary dictionaryWithObjectsAndKeys:
								 user.email, @"user_id",
								 message, @"body",
								 nil],
                                @"message", nil];
    
    SBJSON *parser = [[SBJSON alloc] init];
    NSString *newJsonString = [parser stringWithObject:dictionary];
    //NSString *finalJsonString = [NSString stringWithFormat:@"{ \"message\": %@ }", newJsonString];
    
    [parser release];
    NSLog(@"newJsonString: %@", newJsonString);
	
	// NSString *jsonStringForSessionCreation = [user jsonStringForSessionCreation];
    // NSLog(@"jsonStringForSessionCreation: %@", jsonStringForSessionCreation);
    
    NSString *urlString = @"http://flak.heroku.com/messages.json";
	
    [self postToFlak:urlString 
		  jsonString: newJsonString];
}

- (void)createNewAccount{
    IPDCUser *user = [self getUser];
    NSString *jsonStringForUser = [user jsonStringForUserCreation];
	NSLog(@"createNewAccount: %@", jsonStringForUser);
    NSString *urlString = @"http://flak.heroku.com/users.json";

    [self postToFlak:urlString 
		  jsonString: jsonStringForUser];
}
	
- (void) postToFlak: (NSString *) urlString jsonString: (NSString *) jsonStringToUse  {

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

- (void)initAndGetCookies{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    // IPDCMessageManager *messageManager = [[IPDCMessageManager alloc] init];

    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];

    NSURL *url = [NSURL URLWithString:@"http://flak.heroku.com"];
    NSLog(@"cookies: %@", [cookieStorage cookiesForURL:url]);
    [pool drain];
}

- (void)retrieveNextMessages {
	NSNumber *maxMessageId = [self.flakManager.rootViewController getMaxMessageId];
	NSLog(@"we have retrieved the maxMessageId: %@", maxMessageId);

    SBJSON *parser = [[SBJSON alloc] init];
	NSString *myUrl = [NSString stringWithFormat:@"http://flak.heroku.com/messages.json?kind=message&after_id=%@", maxMessageId];

    NSURL *url = [NSURL URLWithString:myUrl];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];

    //NSLog(@"jsonString: %@", jsonString);
    NSArray *jsonArray = [parser objectWithString:jsonString];
    //NSLog(@"json array: %@", jsonArray);
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

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
	
    [super dealloc];
}

@end
