//
//  BEIUtils.h
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class NDTrie;

@interface BEIUtils : NSObject

/**
 *  Constructs the Trie from the inputs of our file.
 *
 *  @return Trie object constructed from the
 */
+ (NDTrie*) constructTrie;

@end
