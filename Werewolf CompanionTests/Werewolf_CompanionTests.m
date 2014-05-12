//
//  Werewolf_CompanionTests.m
//  Werewolf CompanionTests
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate+CoreDataContext.h"
#import "Game.h"
#import "GameSetup.h"
#import "Player.h"
#import "Role.h"
#import "Werewolf.h"
#import "Villager.h"
#import "Priest.h"
#import "Seer.h"
#import "Vigilante.h"
#import "Hunter.h"
#import "Minion.h"
#import "Nemesis.h"

@interface Werewolf_CompanionTests : XCTestCase
{
    GameSetup *defaultSetup;
    Game *game;
    NSManagedObjectContext *objectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *moc;

@end

@implementation Werewolf_CompanionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle mainBundle]]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    XCTAssertTrue([psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    self.moc = [[NSManagedObjectContext alloc] init];
    self.moc.persistentStoreCoordinator = psc;
    
    GameSetup *assassinSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                             inManagedObjectContext:self.moc];
    assassinSetup.name = @"5P Nemesis";
    assassinSetup.numWerewolf = @1;
    assassinSetup.numVillager = @3;
    assassinSetup.numNemesis = @1;
    assassinSetup.isDefault = @YES;
    
    GameSetup *fivesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                          inManagedObjectContext:self.moc];
    fivesSetup.name = @"5P Special";
    fivesSetup.numWerewolf = @1;
    fivesSetup.numVillager = @1;
    fivesSetup.numHunter = @1;
    fivesSetup.numSeer = @1;
    fivesSetup.numMinion = @1;
    fivesSetup.isDefault = @YES;
    
    GameSetup *sevensSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                           inManagedObjectContext:self.moc];
    sevensSetup.name = @"7P Classic";
    sevensSetup.numWerewolf = @2;
    sevensSetup.numVillager = @4;
    sevensSetup.numSeer = @1;
    sevensSetup.isDefault = @YES;
    
    GameSetup *ninesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                          inManagedObjectContext:self.moc];
    ninesSetup.name = @"9P Classic";
    ninesSetup.numWerewolf = @2;
    ninesSetup.numVillager = @6;
    ninesSetup.numSeer = @1;
    ninesSetup.isDefault = @YES;

    

    
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"GameSetup"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name = %@", @"5P Special"]];
    defaultSetup = [[self.moc executeFetchRequest:fetchRequest error:&error] firstObject];
    
    NSLog(@"name of setup: %@", defaultSetup.name);
    
    game = [[Game alloc] initWithGameSetup:defaultSetup];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGameCheckNightResults
{
    for (Player *player in game.players) {
        XCTAssertTrue(!player.isDead, @"New players should not be dead");
        XCTAssert(!player.isWolfTarget, @"New players should not be wolf targets");
        XCTAssert(!player.isPriestTarget, @"New players should not be priest targets");
    }
    
    [game.wolfTargets addObject:game.players[0]];
    
    NSLog(@"%@",[game checkNightResult]);
    
    
}


@end
