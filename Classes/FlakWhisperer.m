//
//  FlakWhisperer.m
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import "FlakWhisperer.h"


@implementation FlakWhisperer

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