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

@implementation FirstViewController

- (IBAction)testFlak{
	[self testForFlakServer:@"http://flak.heroku.com"];
}

- (IBAction)testGettingMessages{
	[self initAndGetCookies];
	[self retrieveNextTenMessages];
}


- (void)initAndGetCookies{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
    //IPDCMessageManager *messageManager = [[IPDCMessageManager alloc] init];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    NSURL *url = [NSURL URLWithString:@"http://flak.heroku.com"];
    
    NSLog(@"cookies: %@", [cookieStorage cookiesForURL:url]);
    
    //[messageManager userCreationFlakTest];
    //[messageManager sessionCreationFlakTest];
	
    //[messageManager messageCreateFlakTestTouch];
    //[messageManager retrieveNextTenMessages];
    
    //[messageManager sessionDestroyFlakTest];
    //[messageManager release];
    
    [pool drain];
	
}
- (void)retrieveNextTenMessages {
	
    SBJSON *parser = [[SBJSON alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://flak.heroku.com/messages.json"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonString: %@", jsonString);
    
    NSArray *jsonArray = [parser objectWithString:jsonString];
    //NSLog(@"json array: %@", jsonArray);
    
    NSMutableArray *messages = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *messageDictionary in jsonArray) {
        
        IPDCMessage *message = [[IPDCMessage alloc] initWithJsonDictionary:messageDictionary];
		
        NSLog(@"new message: %@", message);
        
        [message release];
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
	
//    if (statusCode == 200) {
//        return YES;
//    } else {
//        return NO;
//    }
	
	
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super dealloc];
}

@end
