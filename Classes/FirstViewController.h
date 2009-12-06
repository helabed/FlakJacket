//
//  FirstViewController.h
//  blankTabBarNav
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IPDCUser;
@class FlakManager;

@interface FirstViewController : UIViewController {

	FlakManager *flakManager;

}
@property (nonatomic, retain) IBOutlet 	FlakManager *flakManager;


- (IBAction)testFlak;
- (IBAction)testCreateNewAccount;
- (IBAction)testGettingMessages;
- (IBAction)testLogin;
- (IBAction)testPostHelloFromHani;

- (void)testForFlakServer:(NSString *)hostURL;
- (void)retrieveNextMessages;
- (void)initAndGetCookies;
- (void)createNewAccount;
- (void)createNewSessionForLogin;
- (void)postToFlak: (NSString *) urlString jsonString: (NSString *) jsonStringToUse; 
- (IPDCUser *)getUser;
- (void)postAHelloFromHani;
- (void)postMessage:(NSString *)messageBody;
@end
