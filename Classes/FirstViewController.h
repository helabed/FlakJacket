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
@class UserPreferences;

@interface FirstViewController : UIViewController {
	FlakManager *flakManager;
	UserPreferences *preferences;
}

@property(nonatomic, retain) IBOutlet FlakManager *flakManager;
@property(nonatomic, retain) IBOutlet UserPreferences *preferences;


- (IBAction)testFlak;
- (IBAction)testCreateNewAccount;
- (IBAction)testGettingMessages;
- (IBAction)testLogin;
- (IBAction)testPostHelloFromUser;

- (void)testForFlakServer:(NSString *)hostURL;
- (void)retrieveNextMessages;
- (void)initAndGetCookies;
- (void)createNewAccount;
- (void)createNewSessionForLogin;
- (IPDCUser *)getUser;
- (void)postAHelloFromUser;
- (void)postMessage:(NSString *)messageBody;

@end
