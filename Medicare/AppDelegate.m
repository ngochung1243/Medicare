//
//  AppDelegate.m
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import "AppDelegate.h"
#import "MedicarePlacesViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[MedicarePlacesViewController new]];
    _window.rootViewController = navController;
    [_window makeKeyAndVisible];
    return YES;
}


@end
