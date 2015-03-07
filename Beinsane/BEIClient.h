//
//  BEIClient.h
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BEIResponse;

typedef void (^BEIClientCompletionHandler)(BEIResponse* response, NSError *error) ;

@interface BEIClient : NSURLSession

/**
 *  Calls custom query api of google.
 *
 *  @param query   Text to query
 *  @param handler Result is returned in this block
 */
+ (void) performQueryCall:(NSString*)query completionHandler:(BEIClientCompletionHandler)handler;

@end
