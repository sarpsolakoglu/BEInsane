//
//  AppDelegate.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIAppDelegate.h"
#import "BEIQueryManager.h"

@interface BEIAppDelegate ()

@end

@implementation BEIAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Load the trie to memory
    [BEIQueryManager loadTrie];
    //Set status bar color
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //Set app appearance
    [self setAppearance];
    
    return YES;
}

- (void) setAppearance {
    //Set navigation bar appearance
    UINavigationBar *navBarAppearance = [UINavigationBar appearance];
    navBarAppearance.tintColor = [UIColor yellowColor];
    navBarAppearance.barTintColor = [UIColor redColor];
    navBarAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor yellowColor]};
    //Set toolbar appearance
    UIToolbar *toolbarAppearance = [UIToolbar appearance];
    toolbarAppearance.tintColor = [UIColor yellowColor];
    toolbarAppearance.barTintColor = [UIColor redColor];
    //Set indicator view appearance
    UIActivityIndicatorView *activityAppearance = [UIActivityIndicatorView appearance];
    activityAppearance.color = [UIColor blackColor];
    //Set progress view appearance
    UIProgressView *progressAppearance = [UIProgressView appearance];
    progressAppearance.trackTintColor = [UIColor blackColor];
    progressAppearance.progressTintColor = [UIColor yellowColor];
}

@end
