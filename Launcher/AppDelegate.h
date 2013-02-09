//
//  AppDelegate.h
//  Launcher
//
//  Created by Enrique W on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Launcher.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate>{
    UITabBarController *tabBarController;
    Launcher *viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) Launcher *viewController;
@property (nonatomic, retain) UITabBarController *tabBarController;

@end
