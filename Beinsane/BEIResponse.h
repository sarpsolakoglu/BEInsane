//
//  BEIResponse.h
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BEIResponse : NSObject

@end

@interface BEIResponseCustomQuery : BEIResponse
/**
 *  Array of BEICustomQueryNode objects
 */
@property (nonatomic, strong) NSArray *items;
/**
 *  Creates BEIResponseCustomQuery object from json
 *
 *  @param json JSON returned from Google API
 *
 *  @return BEIResponseCustomQuery object
 */
+ (BEIResponseCustomQuery*) createWithJson:(NSDictionary*)json;
@end

@interface BEICustomQueryNode : NSObject
/**
 *  link to search result
 */
@property (nonatomic, copy) NSString *link;
/**
 *  explanation
 */
@property (nonatomic, copy) NSString *snippet;
/**
 *  title
 */
@property (nonatomic, copy) NSString *title;
/**
 *  img src
 */
@property (nonatomic, copy) NSString *src;
/**
 *  Creates BEICustomQueryNode from json
 *
 *  @param json JSON returned from Google API
 *
 *  @return BEICustomQueryNode object
 */
+ (BEICustomQueryNode*) createWithJson:(NSDictionary*)json;
@end