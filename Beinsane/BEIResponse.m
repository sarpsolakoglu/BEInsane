//
//  BEIResponse.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIResponse.h"

@implementation BEIResponse

@end

@implementation BEIResponseCustomQuery

+ (BEIResponseCustomQuery*) createWithJson:(NSDictionary*)json {
    BEIResponseCustomQuery *response = [BEIResponseCustomQuery new];
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *item in json[@"items"]) {
        BEICustomQueryNode *node = [BEICustomQueryNode createWithJson:item];
        [items addObject:node];
    }
    response.items = items;
    return response;
}

@end

@implementation BEICustomQueryNode

+ (BEICustomQueryNode*) createWithJson:(NSDictionary*)json {
    BEICustomQueryNode *node = [BEICustomQueryNode new];
    node.link = json[@"link"];
    node.snippet = json[@"snippet"];
    node.title = json[@"title"];
    node.src = json[@"pagemap"][@"cse_image"][0][@"src"];
    return node;
}

@end