//
//  FlakWhisperer.h
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserPreferences;

@interface FlakWhisperer : NSObject {
	UserPreferences *preferences;
}

@property(nonatomic, retain) IBOutlet UserPreferences *preferences;

-(void)initAndGetCookies;
-(void)createNewSessionForLogin;
-(void)postMessage:(NSString *)messageBody;
+(void)postToFlak:(NSString *)urlString jsonString:(NSString *)jsonStringToUse; 

@end