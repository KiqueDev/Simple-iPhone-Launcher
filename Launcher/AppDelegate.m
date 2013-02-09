//
//  AppDelegate.m
//  Launcher
//
//  Created by Enrique W on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@class Launcher;

@synthesize window = _window;
@synthesize viewController;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor redColor];

    
    // set up a local nav controller which we will reuse for each view controller
    UINavigationController *localNavigationController;
    
    tabBarController = [[UITabBarController alloc] init];

    viewController= [[Launcher alloc] init];
    //viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
    
    NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] init];
    
    // create the nav controller and add the root view controller as its first view
    localNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    localNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    localNavigationController.delegate = self;
 
    [localViewControllersArray addObject:localNavigationController];
    tabBarController.viewControllers = localViewControllersArray;
    
    [tabBarController.view setFrame:CGRectMake(0,0, 320, 480)];
    [tabBarController.tabBar setFrame:CGRectMake(0, 0, 0, 0)];

    [tabBarController.view addSubview:localNavigationController.navigationBar];

    [self.window addSubview:tabBarController.view];

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)dealloc{
    [super dealloc];

}

@end
