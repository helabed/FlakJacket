//
//  IPDCUser.h
//  json_tests
//
//  Created by Eric Knapp on 10/28/09.
//  Copyright 2009 Madison Area Technical College. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SBJSON;

@interface IPDCUser : NSObject {

    NSNumber * userId;
    NSString * password;
    NSString * firstName;
    NSDate * timeStamp;
    NSString * email;
    NSDate * createdAt;
    NSDate * lastActivityAt;
    NSString * lastName;
    
}

@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * lastActivityAt;
@property (nonatomic, retain) NSString * lastName;

- (id)initWithJsonGeneralUser:(NSMutableDictionary *)userDictionary;
- (NSString *)jsonStringForUserCreation;
- (NSDictionary *)userAsDictionary;
- (NSString *)jsonStringForSessionCreation;

@end
