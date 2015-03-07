//
//  BEIUtils.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIUtils.h"
#import "NDTrie.h"

static NSString* const fileName = @"british-english-insane";

@implementation BEIUtils


+ (NDTrie*) constructTrie {
    NSDate *start = [NSDate date];
    NDTrie *trie = [NDTrie trieWithArray:[BEIUtils readTextFile]];
    NSLog(@"%s: executed in %f seconds",__PRETTY_FUNCTION__,[[NSDate date] timeIntervalSinceDate:start]);
    return trie;
}

+ (NSArray*) readTextFile {
    NSDate *start = [NSDate date];
    //Get file path
    NSString *fileName = [BEIUtils getFilePath];
    //Get the file contents as string
    NSString *fileContents = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:NULL];
    //Fill our array with the strings seperated by new line
    NSMutableArray *stringList = [NSMutableArray arrayWithArray:[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    //Last object is "" so remove it from the array
    [stringList removeLastObject];
    NSLog(@"%s: executed in %f seconds",__PRETTY_FUNCTION__,[[NSDate date] timeIntervalSinceDate:start]);
    return stringList;
}

+ (NSString*) getFilePath {
    return [[NSBundle mainBundle] pathForResource:fileName
                                           ofType:@"txt"];
}

@end
