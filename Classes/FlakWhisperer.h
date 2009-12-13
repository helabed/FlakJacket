//
//  FlakWhisperer.h
//  blankCoreData
//
//  Created by Stephen Anderson on 12/13/09.
//  Copyright 2009 Bendyworks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FlakWhisperer : NSObject {

}

+(void)postToFlak:(NSString *)urlString jsonString:(NSString *)jsonStringToUse; 

@end