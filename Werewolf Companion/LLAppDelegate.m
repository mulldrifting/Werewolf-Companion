//
//  LLAppDelegate.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLAppDelegate.h"
#import "AppDelegate+CoreDataContext.h"
#import "GameSetup.h"

const static NSString *kDefault = @"";

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    NSDictionary *defaults = @{@"kDefaultTimerStartValue": @600000};
    [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
    
    LLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate createManagedObjectContext:^(NSManagedObjectContext *context) {
        self.objectContext = context;
    }];
    
    [self addInitialGameSetups];
    
    return YES;
}

- (void)addInitialGameSetups
{
    GameSetup *assassinSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.objectContext];
    assassinSetup.name = @"5P Assassin";
    assassinSetup.numWerewolf = @1;
    assassinSetup.numVillager = @3;
    assassinSetup.numAssassin = @1;
    assassinSetup.wolvesSeeRoleOfKill = @NO;
    
    GameSetup *fivesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.objectContext];
    fivesSetup.name = @"5P Special";
    fivesSetup.numWerewolf = @1;
    fivesSetup.numVillager = @1;
    fivesSetup.numHunter = @1;
    fivesSetup.numSeer = @1;
    fivesSetup.numMinion = @1;
    
    GameSetup *sevensSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.objectContext];
    sevensSetup.name = @"7P Classic";
    sevensSetup.numWerewolf = @2;
    sevensSetup.numVillager = @4;
    sevensSetup.numSeer = @1;
    sevensSetup.wolvesSeeRoleOfKill = @NO;
    
    GameSetup *ninesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.objectContext];
    ninesSetup.name = @"9P Classic";
    ninesSetup.numWerewolf = @2;
    ninesSetup.numVillager = @6;
    ninesSetup.numSeer = @1;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
