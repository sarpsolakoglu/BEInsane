//
//  BEIQueryManager.h
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NDTrie;

typedef void (^BEIQueryResult)(NSArray* results);

@interface BEIQueryManager : NSObject

/**
 *  Returns BEIQueryManager singleton object
 *
 *  @return BEIQueryManager singleton object
 */
+ (BEIQueryManager*) sharedManager;
/**
 *  Need to call at start-up before using the query.
 */
+ (void) loadTrie;
/**
 *  Returns an array of strings containing the query string. Result is returned in a block. loadTrie needs to be called first;
 *
 *  @param query  String to query
 *  @param result Block returning the NSArray
 */
+ (void) queryWithString:(NSString*)query block:(BEIQueryResult)result;

@end
