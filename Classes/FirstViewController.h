//
//  FirstViewController.h
//  blankTabBarNav
//
//  Created by Hani Elabed on 11/19/09.
//  Copyright Elabed Enterprises, LLC 2009. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {

}
- (IBAction)testFlak;
- (IBAction)testGettingMessages;
- (void)testForFlakServer:(NSString *)hostURL;
- (void)retrieveNextTenMessages;
- (void)initAndGetCookies;

@end
