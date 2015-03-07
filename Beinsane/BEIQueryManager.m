//
//  BEIQueryManager.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIQueryManager.h"
#import "NDTrie.h"
#import "BEIUtils.h"

@interface BEIQueryManager ()
@property (nonatomic, strong) NDTrie* trie;
@end

@implementation BEIQueryManager

+ (BEIQueryManager*) sharedManager {
    static BEIQueryManager *sharedManager;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        sharedManager = [[BEIQueryManager alloc] init];
    });
    return sharedManager;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.trie = [[NDTrie alloc] init];
    }
    return self;
}

+ (void) loadTrie {
    [BEIQueryManager sharedManager].trie = [BEIUtils constructTrie];
}

#pragma mark - query methods


+ (void) queryWithString:(NSString*)query block:(BEIQueryResult)result {
    NSDate *start = [NSDate date];
    NSArray *returnArary = [NSArray new];
    if (query.length != 0) {
        returnArary = [[BEIQueryManager sharedManager].trie everyObjectForKeyWithPrefix:query];
    }
    result(returnArary);
    NSLog(@"Trie retrieve for \"%@\": executed in %f seconds",query,[[NSDate date] timeIntervalSinceDate:start]);
}

@end
